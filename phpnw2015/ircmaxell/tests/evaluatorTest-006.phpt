--TEST--
Test float multiplication using evaluator
--FILE--
<?php

$formula = '1.2 * 2.3';

$math = new \Evaluator\Math();

$answer = $math->evaluate($formula);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
1.2 * 2.3 => float(2.76)