--TEST--
Test bracketed formula using evaluator
--FILE--
<?php

$formula = '2 * ((3 + 7) / 5) ^ (2 ^ -1.5)';

$math = new \Evaluator\Math();

$answer = round($math->evaluate($formula), 4);
echo $formula, ' => ';
var_dump($answer);


--EXPECT--
2 * ((3 + 7) / 5) ^ (2 ^ -1.5) => float(2.5554)
