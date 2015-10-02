namespace Evaluator\Operators;

use Evaluator\Stack;

class Division extends Operator
{
    protected precedence = 5;

    public function operate(<Stack> stack)
    {
        var left, right;

        let left =  stack->pop()->operate(stack);
        if left == 0.0 {
            throw new \Exception("Division by zero");
        }
        let right =  stack->pop()->operate(stack);

        return right / left;
    }
}