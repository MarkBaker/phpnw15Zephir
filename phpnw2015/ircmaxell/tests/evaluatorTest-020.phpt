--TEST--
Test invalid operator error when using evaluator
--FILE--
<?php

$formula = '((2 + 3) = 4)';

$math = new \Evaluator\Math();

try {
    $answer = $math->evaluate($formula);
} catch (Exception $e) {
    $answer = $e->getMessage();
}

echo $formula, ' => ';
var_dump($answer);


--EXPECT--
((2 + 3) = 4) => string(17) "Undefined Value ="
