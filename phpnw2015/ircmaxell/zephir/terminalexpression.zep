namespace Evaluator;

abstract class TerminalExpression
{
    protected value = "";

    public function __construct(value) -> void
    {
        let this->value = value;
    }

    public static function factory(value)
    {
        if is_object(value) && value instanceof TerminalExpression {
            return value;
        } elseif is_numeric(value) {
            return new Number(value);
        } elseif value == "+" {
            return new Operators\Addition(value);
        } elseif value == "-" {
            return new Operators\Subtraction(value);
        } elseif value == "*" {
            return new Operators\Multiplication(value);
        } elseif value == "/" {
            return new Operators\Division(value);
        } elseif value == "^" {
            return new Operators\Power(value);
        } else {
            if in_array(value, ["(", ")"]) {
                return new Parenthesis(value);
            }
        }
        throw new \Exception("Undefined Value " . value);
    }

    public abstract function operate(<Stack> stack) -> void;

    public function isOperator()
    {
        return false;
    }

    public function isParenthesis()
    {
        return false;
    }

    public function isNoOp()
    {
        return false;
    }

    public function render()
    {
        return this->value;
    }
}