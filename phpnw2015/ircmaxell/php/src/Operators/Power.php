<?php

namespace Evaluator\Operators;

use \Evaluator\Stack;

class Power extends Operator {

    protected $precedence = 6;

    public function operate(Stack $stack) {
        $left = $stack->pop()->operate($stack);
        $right = $stack->pop()->operate($stack);
        return pow($right, $left);
    }
}
