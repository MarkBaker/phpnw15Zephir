namespace QuadTrees;

/**
 *
 * QuadTree X/Y Point class
 *
 * @package QuadTree
 * @copyright  Copyright (c) 2013 Mark Baker (https://github.com/MarkBaker/Tries)
 * @license    http://www.gnu.org/licenses/lgpl-3.0.txt    LGPL
 */
class QuadTreeXYPoint
{
    /**
     * X or Longitude coordinate of this point
     *
     * @var   float
     **/
    protected x;

    /**
     * Y or Latitude coordinate of this point
     *
     * @var   float
     **/
    protected y;

    /**
     * Create an x/y node point
     *
     * @param   float            $x         The X (or Longitude) coordinate of this point
     * @param   float            $y         The Y (or Latitude) coordinate of this point
     * @throws \InvalidArgumentException
     */
    public function __construct(float x = 0.0, float y = 0.0) -> void
    {
        if !is_numeric(x) || !is_numeric(y) {
            throw new \InvalidArgumentException("Point coordinates must be numeric values");
        }
        let this->x = x;
        let this->y = y;
    }

    /**
     * Fetch the X coordinate (or Longitude) for this point
     *
     * @return  float    Value of the X (or Longitude) coordinate
     */
    public function getX() -> float
    {
        return this->x;
    }

    /**
     * Fetch the Y coordinate (or Latitude) for this point
     *
     * @return  float    Value of the Y (or Latitude) coordinate
     */
    public function getY() -> float
    {
        return this->y;
    }
}