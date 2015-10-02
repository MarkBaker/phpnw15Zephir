--TEST--
Test float power using evaluator
--FILE--
<?php

$formula = '1.2 ^ 2.4';

$math = new \Evaluator\Math();

$answer = round($math->evaluate($formula), 4);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
1.2 ^ 2.4 => float(1.5489)