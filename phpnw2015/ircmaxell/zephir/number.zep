namespace Evaluator;

class Number extends TerminalExpression
{
    public function operate(<Stack> stack)
    {
        return this->value;
    }
}