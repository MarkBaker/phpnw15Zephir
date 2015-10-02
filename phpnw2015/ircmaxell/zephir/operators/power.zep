namespace Evaluator\Operators;

use Evaluator\Stack;

class Power extends Operator
{
    protected precedence = 6;

    public function operate(<Stack> stack)
    {
        var left, right;

        let left =  stack->pop()->operate(stack);
        let right =  stack->pop()->operate(stack);

        return pow(right, left);
    }
}