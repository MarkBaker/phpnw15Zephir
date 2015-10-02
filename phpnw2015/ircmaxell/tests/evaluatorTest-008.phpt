--TEST--
Test signed integer subtraction using evaluator
--FILE--
<?php

$formula = '2 - -3';

$math = new \Evaluator\Math();

$answer = $math->evaluate($formula);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
2 - -3 => int(5)