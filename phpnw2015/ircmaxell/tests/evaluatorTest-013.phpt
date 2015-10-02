--TEST--
Test integer power using evaluator
--FILE--
<?php

$formula = '2 ^ 4';

$math = new \Evaluator\Math();

$answer = $math->evaluate($formula);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
2 ^ 4 => int(16)