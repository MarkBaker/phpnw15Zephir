<?php

namespace Tries;

/**
 *
 * TrieNode class
 *
 * @package Tries
 * @copyright  Copyright (c) 2013 Mark Baker (https://github.com/MarkBaker/Tries)
 * @license    http://www.gnu.org/licenses/lgpl-3.0.txt    LGPL
 */
class TrieNode
{
    /**
     * Array of child nodes indexed by next character
     *
     * @var   TrieNode[]
     **/
    public $children = [];

    /**
     * Data value (empty unless this is an end node)
     *
     * @var   mixed
     **/
    public $value = null;

}
