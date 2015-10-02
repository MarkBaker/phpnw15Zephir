--TEST--
Test formula with dynamic values using evaluator
--FILE--
<?php

$x = 2.5;
$y = 4;
$z = 5;

$formula = '2 * ($z + ($x / $y))';

$math = new \Evaluator\Math();
$math->registerVariable('x', $x);
$math->registerVariable('y', $y);
$math->registerVariable('z', $z);

$answer = round($math->evaluate($formula), 4);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
2 * ($z + ($x / $y)) => float(11.25)
