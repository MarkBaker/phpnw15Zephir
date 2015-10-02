<?php

namespace Evaluator\Operators;

use \Evaluator\Stack;

class Division extends Operator {

    protected $precedence = 5;

    public function operate(Stack $stack) {
        $left = $stack->pop()->operate($stack);
        $right = $stack->pop()->operate($stack);
        return $right / $left;
    }
}
