<?php

$callStartTime = microtime(true);

// Include the autoloader
require_once __DIR__ . '/../Evaluator.php';


$math = new \Evaluator\Math();

$math->registerVariable('a', 2.5);
$math->registerVariable('abc', 5.75);

$formulae = [
    '(2 + 3) * 4',                                                      // 20
    '2 + 3 * 4',                                                        // 14
    '+2 - -4',                                                          // 6
    '-2.5 - +4.5',                                                      // -7
    '2 + -4',                                                           // -2
    '1 + 2 * ((3 + 4) * 5 + 6)',                                        // 83
    '(1 + 2) * (3 + 4) * (5 + 6)',                                      // 231
    '(-3/2 + 3) * 4',                                                   // 6
    '(3/2 + 3) * 4',                                                    // 18
    '((1.25 + 2.35) / (3.45 + 4.5) / (5 + 6.75)) * (7.5 * 8.5^9.5)',    // 195181460.39783
    '(1 + 2) * (3 - 4) * (5 + 6)',                                      // -33
    '($a + 4) * 4',                                                     // 26
    '($abc + $a) * 4',                                                  // 33
    '$abc^$a',                                                          // 79.281089869763
];

foreach($formulae as $formula) {
    $answer = $math->evaluate($formula);
    echo $formula, ' => ';
    var_dump($answer);
}


// Echo timing
$callEndTime = microtime(true);
$callTime = $callEndTime - $callStartTime;

echo PHP_EOL, 'Call time was ' , sprintf('%.4f',$callTime) , " seconds" , PHP_EOL;

// Echo memory usage
echo date('H:i:s') , ' Current memory usage: ' , (memory_get_usage(true) / 1024 / 1024) , " MB" , PHP_EOL;

// Echo memory peak usage
echo date('H:i:s') , " Peak memory usage: " , (memory_get_peak_usage(true) / 1024 / 1024) , " MB" , PHP_EOL;

