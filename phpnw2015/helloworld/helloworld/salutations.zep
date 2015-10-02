namespace HelloWorld;

class salutations
{

    protected greeting = [
        "en": "Hello World",
        "fr": "Bonjour le monde",
        "es": "Hola mundo",
        "de": "Hallo Welt",
        "it": "Ciao mondo",
        "pt": "Ola mundo",
        "nl": "Hallo Wereld"
    ];

    protected function greeting(language)
    {
        var greeting;

        let greeting = $this->greeting[language];
        echo greeting, PHP_EOL;

    }

    public function english()
    {
        this->greeting("en");
    }

    public function french()
    {
        this->greeting("fr");
    }

    public function spanish()
    {
        this->greeting("es");
    }

    public function german()
    {
        this->greeting("de");
    }

    public function italian()
    {
        this->greeting("it");
    }

    public function portuguese()
    {
        this->greeting("pt");
    }

    public function dutch()
    {
        this->greeting("nl");
    }

}

