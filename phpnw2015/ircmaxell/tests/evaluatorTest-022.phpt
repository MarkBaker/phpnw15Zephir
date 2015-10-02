--TEST--
Test unset value defaults to 0 when using evaluator
--FILE--
<?php

$formula = '((2 + $x) * 3)';

$math = new \Evaluator\Math();

try {
    $answer = $math->evaluate($formula);
} catch (Exception $e) {
    $answer = $e->getMessage();
}

echo $formula, ' => ';
var_dump($answer);


--EXPECT--
((2 + $x) * 3) => int(6)
