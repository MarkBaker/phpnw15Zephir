namespace QuadTrees;

/**
 *
 * QuadTree class
 *
 * @package QuadTree
 * @copyright  Copyright (c) 2013 Mark Baker (https://github.com/MarkBaker/Tries)
 * @license    http://www.gnu.org/licenses/lgpl-3.0.txt    LGPL
 */
class QuadTree
{
    /**
     * Default for the maximum number of points that can be stored in any individual QuadTree node
     *    before it splits into child nodes
     *
     * @const   QUADTREE_NODE_CAPACITY
     **/
    const QUADTREE_NODE_CAPACITY = 4;

    /**
     * The Bounding box that this QuadTree node encompasses
     *
     * @var   QuadTreeBoundingBox
     **/
    protected boundingBox;

    /**
     * The maximum number of points that can be stored in this QuadTree node
     *
     * @var   integer
     **/
    protected maxPoints;

    /**
     * Array of the points that are actually stored in this QuadTree node
     *
     * @var   QuadTreeXYPoint[]
     **/
    protected points = [];

    /**
     * QuadTree node for the North-West quadrant of this QuadTree node
     *
     * @var   QuadTree
     **/
    protected northWest;

    /**
     * QuadTree node for the North-East quadrant of this QuadTree node
     *
     * @var   QuadTree
     **/
    protected northEast;

    /**
     * QuadTree node for the South-West quadrant of this QuadTree node
     *
     * @var   QuadTree
     **/
    protected southWest;

    /**
     * QuadTree node for the South-East quadrant of this QuadTree node
     *
     * @var   QuadTree
     **/
    protected southEast;

    /**
     * Create a bounding box
     *
     * @param   QuadTreeBoundingBox  $boundingBox   The bounding box that defines this QuadTree node
     * @param   integer              $maxPoints     The maximum number of X/Y points to store in this node
     *                                                  before it splits
     */
    public function __construct(<QuadTreeBoundingBox> boundingBox, int maxPoints = self::QUADTREE_NODE_CAPACITY) -> void
    {
        if !is_numeric(maxPoints) || maxPoints < 1 {
            throw new \InvalidArgumentException("Maximum number of points to store in this node must be a positive integer");
        }
        let this->boundingBox = boundingBox;
        let this->maxPoints = intval(maxPoints);
    }

    /**
     * Insert a new point into this QuadTree node
     *
     * @param    QuadTreeXYPoint    $point    The new point to insert in this QuadTree node
     * @return   boolean
     **/
    public function insert(<QuadTreeXYPoint> point) -> boolean
    {
        if !this->boundingBox->containsPoint(point) {
            return false;
        }

        if count(this->points) < this->maxPoints {
            // If we still have spaces in the bucket array for this QuadTree node,
            //    then the point simply goes here and we're finished
            let this->points[] = point;
            return true;
        } elseif this->northWest === null {
            // Otherwise we split this node into NW/NE/SE/SW quadrants
            this->subdivide();
        }

        // Insert the point into the appropriate quadrant, and finish
        if this->northWest->insert(point) || this->northEast->insert(point) || this->southWest->insert(point) || this->southEast->insert(point) {
            return true;
        }

        // If we couldn't insert the new point, then we have an exception situation
        throw new \OutOfBoundsException("Point is outside bounding box");
    }

    /**
     * Split this QuadTree node into four quadrants for NW/NE/SE/SW
     *
     **/
    protected function subdivide() -> void
    {
        var width, height, centrePointX, centrePointY;

        let width = this->boundingBox->getWidth() / 2;
        let height = this->boundingBox->getHeight() / 2;
        let centrePointX = this->boundingBox->getCentrePoint()->getX();
        let centrePointY = this->boundingBox->getCentrePoint()->getY();

        let this->northWest = new QuadTree(
            new QuadTreeBoundingBox(
                new QuadTreeXYPoint(centrePointX - width / 2, centrePointY + height / 2), width, height
            ),
            this->maxPoints
        );
        let this->northEast = new QuadTree(
            new QuadTreeBoundingBox(
                new QuadTreeXYPoint(centrePointX + width / 2, centrePointY + height / 2), width, height
            ), this->maxPoints
        );
        let this->southWest = new QuadTree(
            new QuadTreeBoundingBox(
                new QuadTreeXYPoint(centrePointX - width / 2, centrePointY - height / 2), width, height
            ), this->maxPoints
        );
        let this->southEast = new QuadTree(
            new QuadTreeBoundingBox(
                new QuadTreeXYPoint(centrePointX + width / 2, centrePointY - height / 2), width, height
            ), this->maxPoints
        );
    }

    /**
     * Return an array of all points within this QuadTree and its child nodes that fall
     *    within the specified bounding box
     *
     * @param    QuadTreeBoundingBox    $boundary    The bounding box that we want to search
     * @return   QuadTreeXYPoint[]
     **/
    public function search(<QuadTreeBoundingBox> boundary)
    {
        var results, point;

        let results = [];

        if this->boundingBox->encompasses(boundary) || this->boundingBox->intersects(boundary) {
            // Test each point that falls within the current QuadTree node
            for point in this->points {
                // Test each point stored in this QuadTree node in turn, adding to the results array
                //    if it falls within the bounding box
                if boundary->containsPoint(point) {
                    let results[] = point;
                }
            }

            // If we have child QuadTree nodes....
            if this->northWest !== null {
                // ... search each child node in turn, merging with any existing results
                let results = array_merge(
                    results,
                    this->northWest->search(boundary),
                    this->northEast->search(boundary),
                    this->southWest->search(boundary),
                    this->southEast->search(boundary)
                );
            }
        }

        return results;
    }
}