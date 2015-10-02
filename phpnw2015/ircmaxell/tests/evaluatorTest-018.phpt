--TEST--
Test division by zero error when using evaluator
--FILE--
<?php

$formula = '2 / 0';

$math = new \Evaluator\Math();

try {
    $answer = $math->evaluate($formula);
} catch (Exception $e) {
    $answer = $e->getMessage();
}

echo $formula, ' => ';
var_dump($answer);


--EXPECT--
2 / 0 => string(16) "Division by zero"
