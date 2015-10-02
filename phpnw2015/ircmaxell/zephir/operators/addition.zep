namespace Evaluator\Operators;

use Evaluator\Stack;

class Addition extends Operator
{
    protected precedence = 4;

    public function operate(<Stack> stack)
    {
        return stack->pop()->operate(stack) + stack->pop()->operate(stack);
    }
}