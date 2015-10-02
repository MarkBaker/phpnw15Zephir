<?php

namespace Evaluator\Operators;

use \Evaluator\Stack;

class Subtraction extends Operator {

    protected $precedence = 4;

    public function operate(Stack $stack) {
        $left = $stack->pop()->operate($stack);
        $right = $stack->pop()->operate($stack);
        return $right - $left;
    }
}
