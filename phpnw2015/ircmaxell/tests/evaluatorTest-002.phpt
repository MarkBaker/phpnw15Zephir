--TEST--
Test signed integer addition using evaluator
--FILE--
<?php

$formula = '1 + -2';

$math = new \Evaluator\Math();

$answer = $math->evaluate($formula);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
1 + -2 => int(-1)