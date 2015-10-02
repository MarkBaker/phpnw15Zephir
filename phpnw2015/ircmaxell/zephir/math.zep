namespace Evaluator;

class Math
{
    protected variables = [];

    public function evaluate(formula)
    {
        var stack;

        let formula = "(". formula. ")";
        let stack = this->parse(formula);

        return this->run(stack);
    }

    public function parse(formula)
    {
        var tokens, output, operators, token, expression, op;

        let tokens = this->tokenize(formula);
        let output = new Stack();
        let operators = new Stack();
        for token in tokens {
            let token = this->extractVariables(token);
            let expression = TerminalExpression::factory(token);
            if expression->isOperator() {
                this->parseOperator(expression, output, operators);
            } elseif expression->isParenthesis() {
                this->parseParenthesis(expression, output, operators);
            } else {
                output->push(expression);
            }
        }

        let op = operators->pop();
        while (op) {
            if op->isParenthesis() {
                throw new \RuntimeException("Mismatched Parenthesis");
            }
            output->push(op);
            let op = operators->pop();
        }

        return output;
    }

    public function registerVariable(name, value) -> void
    {
        let this->variables[name] = value;
    }

    public function run(<Stack> stack)
    {
        var operator, value;

        let operator = stack->pop();
        while (operator && operator->isOperator()) {
            let value = operator->operate(stack);

            if !is_null(value) {
                stack->push(TerminalExpression::factory(value));
            }
            let operator = stack->pop();
        }

        return operator ? operator->render() : this->render(stack);
    }

    protected function extractVariables(token)
    {
        var key;

        if substr(token, 0, 1) == "$" {
            let key = substr(token, 1);
            return isset this->variables[key] ? this->variables[key] : 0;
        }

        return token;
    }

    protected function render(<Stack> stack)
    {
        var output = "", el;

        let el = stack->pop();
        while (el) {
            let output .= el->render();
        let el = stack->pop();
        }

        if output {
            return output;
        }
        throw new \RuntimeException("Could not render output");
    }

    protected function parseParenthesis(<Parenthesis> expression, <Stack> output, <Stack> operators) -> void
    {
        var clean, end;

        if expression->isOpen() {
            operators->push(expression);
        } else {
            let clean = false;
            let end = operators->pop();
            while (end) {
                if end->isParenthesis() {
                    let clean = true;
                    break;
                } else {
                    output->push(end);
                }
            let end = operators->pop();
            }

            if !clean {
                throw new \RuntimeException("Mismatched Parenthesis");
            }
        }
    }

    protected function parseOperator(<Operators\Operator> expression, <Stack> output, <Stack> operators) -> void
    {
        var end;

        let end = operators->poke();

        if !end {
            operators->push(expression);
        } elseif end->isOperator() {
            do {
                if expression->isLeftAssoc() && expression->getPrecedence() <= end->getPrecedence() {
                    output->push(operators->pop());
                } elseif !expression->isLeftAssoc() && expression->getPrecedence() < end->getPrecedence() {
                    output->push(operators->pop());
                } else {
                    break;
                }
            let end = operators->poke();
            } while (end && end->isOperator());
            operators->push(expression);
        } else {
            operators->push(expression);
        }
    }

    protected function tokenize(formula)
    {
        var parts;
    
        let parts = preg_split("(([-+]?\\d*\\.?\\d+|\\+|-|\\(|\\)|\\*|/|\\^)|\\s+)", formula, null, PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE);
        let parts = array_map("trim", parts);
        
        return parts;
    }
}
