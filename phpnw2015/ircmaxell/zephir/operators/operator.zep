namespace Evaluator\Operators;

abstract class Operator extends \Evaluator\TerminalExpression
{
    protected precedence = 0;
    protected leftAssoc = true;

    public function getPrecedence()
    {
        return this->precedence;
    }

    public function isLeftAssoc()
    {
        return this->leftAssoc;
    }

    public function isOperator()
    {
        return true;
    }
}