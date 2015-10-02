namespace Evaluator\Operators;

use Evaluator\Stack;

class Multiplication extends Operator
{
    protected precedence = 5;

    public function operate(<Stack> stack)
    {
        return stack->pop()->operate(stack) * stack->pop()->operate(stack);
    }
}