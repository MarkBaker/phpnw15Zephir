<?php

use Complex\Complex;

// Include the autoloader
require_once __DIR__ . '/../Complex.php';

echo 'Create', PHP_EOL;
echo '========', PHP_EOL;

$x = new Complex(123);
echo $x, PHP_EOL;

$x = new Complex(123.456);
echo $x, PHP_EOL;

$x = new Complex(123, 456);
echo $x, PHP_EOL;

$x = new Complex([123, 456, 'j']);
echo $x, PHP_EOL;

$x = new Complex([12.34, 56.78]);
echo $x, PHP_EOL;

$x = new Complex([1.23e-4, 5.67e8]);
echo $x, PHP_EOL;

$x = new Complex('1.23e-4--2.34e-5i');
echo $x, PHP_EOL;

$x = new Complex('1.234e-5i');
echo $x, PHP_EOL;


echo PHP_EOL, 'Add', PHP_EOL;
echo '=====', PHP_EOL;

$x = new Complex(123);
$x->add(456);
echo $x, PHP_EOL;

$x = new Complex(123.456);
$x->add(789.012);
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->add(new Complex(-987.654, -32.1));
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->add(-987.654);
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->add(new Complex(0, 1));
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->add(new Complex(0, -1));
echo $x, PHP_EOL;


echo PHP_EOL, 'Subtract', PHP_EOL;
echo '==========', PHP_EOL;

$x = new Complex(123);
$x->subtract(456);
echo $x, PHP_EOL;

$x = new Complex(123.456);
$x->subtract(789.012);
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->subtract(new Complex(-987.654, -32.1));
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->subtract(-987.654);
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->subtract(new Complex(0, 1));
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->subtract(new Complex(0, -1));
echo $x, PHP_EOL;


echo PHP_EOL, 'Multiply', PHP_EOL;
echo '==========', PHP_EOL;

$x = new Complex(123);
$x->multiply(456);
echo $x, PHP_EOL;

$x = new Complex(123.456);
$x->multiply(789.012);
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->multiply(new Complex(-987.654, -32.1));
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->multiply(-987.654);
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->multiply(new Complex(0, 1));
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->multiply(new Complex(0, -1));
echo $x, PHP_EOL;


echo PHP_EOL, 'Divide By', PHP_EOL;
echo '===========', PHP_EOL;

$x = new Complex(123);
$x->divideBy(456);
echo $x, PHP_EOL;

$x = new Complex(123.456);
$x->divideBy(789.012);
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->divideBy(new Complex(-987.654, -32.1));
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->divideBy(-987.654);
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->divideBy(new Complex(0, 1));
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->divideBy(new Complex(0, -1));
echo $x, PHP_EOL;


echo PHP_EOL, 'Divide Into', PHP_EOL;
echo '=============', PHP_EOL;

$x = new Complex(123);
$x->divideInto(456);
echo $x, PHP_EOL;

$x = new Complex(123.456);
$x->divideInto(789.012);
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->divideInto(new Complex(-987.654, -32.1));
echo $x, PHP_EOL;

$x = new Complex(123.456, 78.90);
$x->divideInto(-987.654);
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->divideInto(new Complex(0, 1));
echo $x, PHP_EOL;

$x = new Complex(-987.654, -32.1);
$x->divideInto(new Complex(0, -1));
echo $x, PHP_EOL;
