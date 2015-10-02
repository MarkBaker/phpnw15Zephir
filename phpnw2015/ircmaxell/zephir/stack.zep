namespace Evaluator;

class Stack
{
    protected data = [];

    public function push(element) -> void
    {
        let this->data[] = element;
    }

    public function poke()
    {
        return end(this->data);
    }

    public function pop()
    {
        return array_pop(this->data);
    }
}