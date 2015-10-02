--TEST--
Test Hello World display using helloworld extension
--FILE--
<?php

$instance = new \HelloWorld\greetings();

$instance->english();

--EXPECT--
Hello World