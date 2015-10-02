--TEST--
Test float division using evaluator
--FILE--
<?php

$formula = '1.2 / 2.4';

$math = new \Evaluator\Math();

$answer = $math->evaluate($formula);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
1.2 / 2.4 => float(0.5)