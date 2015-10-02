namespace Evaluator;

class Parenthesis extends TerminalExpression
{
    protected precedence = 7;

    public function operate(<Stack> stack) -> void
    {
    }

    public function getPrecedence()
    {
        return this->precedence;
    }

    public function isNoOp()
    {
        return true;
    }

    public function isParenthesis()
    {
        return true;
    }

    public function isOpen()
    {
        return this->value == "(";
    }
}