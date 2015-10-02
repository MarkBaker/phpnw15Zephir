/**
 *
 * Class for the management of Complex numbers
 *
 * @copyright  Copyright (c) 2013-2015 Mark Baker (https://github.com/MarkBaker/PHPComplex)
 * @license    http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt    LGPL
 */
namespace Complex;

/**
 * Complex Number object.
 *
 * @package Complex
 */
class Complex
{
    /**
     * @var      float    $realPart    The value of of this complex number on the real plane.
     */
    protected realPart = 0;

    /**
     * @var      float    $imaginaryPart    The value of of this complex number on the imaginary plane.
     */
    protected imaginaryPart = 0;

    /**
     * @var      string    $suffix    The suffix for this complex number (i or j).
     */
    protected suffix;

    /**
     * Validates whether the argument is a valid complex number, converting scalar or array values if possible
     *
     * @param    mixed    $complexNumber   The value to parse
     * @return   array
     * @throws   \Exception    If the argument isn't a Complex number or cannot be converted to one
     */
    protected function parseComplex(complexNumber) -> array
    {
        var validComplex, complexParts, imaginary;

        // Test for real number, with no imaginary part
        if is_numeric(complexNumber) {
            return [complexNumber, 0.0, null];
        }

        let complexNumber = str_replace(["+-", "-+", "++", "--"], ["-", "-", "+", "+"], complexNumber);

        // Basic validation of string, to parse out real and imaginary parts, and any suffix
        let validComplex = preg_match(
            "/^([\\-\\+]?(\\d+\\.?\\d*|\\d*\\.?\\d+)([Ee][\\-\\+]?[0-2]?\\d{1,3})?)([\\-\\+]?(\\d+\\.?\\d*|\\d*\\.?\\d+)([Ee][\\-\\+]?[0-2]?\\d{1,3})?)?(([\\-\\+]?)([ij]?))$/ui",
            complexNumber,
            complexParts
        );

        if !validComplex {
            // Neither real nor imaginary part, so test to see if we actually have a suffix
            let validComplex = preg_match("/^([\\-\\+]?)([ij])$/ui", complexNumber, complexParts);
            if !validComplex {
                throw new \Exception("COMPLEX: Invalid complex number");
            }

            // We have a suffix, so set the real part to 0, and the imaginary part to either 1 or -1 (as defined by the sign)
            let imaginary = 1.0;
            if complexParts[1] === "-" {
                let imaginary = 0.0 - imaginary;
            }
            return [0.0, imaginary, complexParts[2]];
        }

        // If we don't have an imaginary part, identify whether it should be +1 or -1...
        if complexParts[4] === "" && complexParts[9] !== "" {
            if complexParts[7] !== complexParts[9] {
                let complexParts[4] = 1.0;
                if complexParts[8] === "-" {
                    let complexParts[4] = -1.0;
                }
            } else {
                // ... or if we have only the real and no imaginary part
                //  (in which case our real should be the imaginary)
                let complexParts[4] = complexParts[1];
                let complexParts[1] = 0.0;
            }
        }

        // Return real and imaginary parts and suffix as an array, and set a default suffix if user input lazily
        return [complexParts[1], complexParts[4], !empty(complexParts[9]) ? complexParts[9] : "i"];
    }

    public function __construct(realPart = 0, imaginaryPart = null, suffix = "i") -> void
    {
        var arrayArguments;

        if imaginaryPart === null {
            if is_array(realPart) {
                // We have an array of (potentially) real and imaginary parts, and any suffix
                let arrayArguments = array_values(realPart);
            } elseif is_string(realPart) || is_numeric(realPart) {
                // We've been given a string to parse to extract the real and imaginary parts, and any suffix
                let arrayArguments = this->parseComplex(realPart);
            }
            let realPart = isset(arrayArguments[0]) ? arrayArguments[0] : 0.0;
            let imaginaryPart = isset(arrayArguments[1]) ? arrayArguments[1] : 0.0;
            let suffix = isset(arrayArguments[2]) ? arrayArguments[2] : "i";

            if suffix === null {
                let suffix = "i";
            }
        }

        // Set parsed values in our properties
        let this->realPart = (double) realPart;
        let this->imaginaryPart = (double) imaginaryPart;
        let this->suffix = strtolower(suffix);
    }

    /**
     * Gets the real part of this complex number
     *
     * @return   Float
     */
    public function getReal() -> float
    {
        return this->realPart;
    }

    /**
     * Gets the imaginary part of this complex number
     *
     * @return   Float
     */
    public function getImaginary() -> float
    {
        return this->imaginaryPart;
    }

    /**
     * Gets the suffix of this complex number
     *
     * @return   String
     */
    public function getSuffix() -> string
    {
        return this->suffix;
    }

    /**
     * Return this complex number as a formatted string value
     *
     * @return   String
     */
    public function format()
    {
        var str;

        let str = "";

        if this->imaginaryPart != 0 {
           if abs(this->imaginaryPart) != 1.0 {
                let str .= this->imaginaryPart . this->suffix;
            } else {
                let str .= (this->imaginaryPart < 0 ? "-" : "") . this->suffix;
            }
        }

        if this->realPart != 0 {
            if str && this->imaginaryPart > 0 {
                let str = "+" . str;
            }
            let str = this->realPart . str;
        }

        if !str {
            let str = "0.0";
        }

        return str;
    }

    /**
     * Magic method to return this complex number as a formatted string value
     *
     * @return   String
     */
    public function __toString()
    {
        return this->format();
    }

    /**
     * Validates whether the argument is a valid complex number, converting scalar or array values if possible
     *
     * @param    mixed    $complex   The value to validate
     * @return   Complex
     * @throws   \Exception          If the argument isn't a Complex number or cannot be converted to one
     */
    public function validateComplexArgument(complex)
    {
        var operand;

        if is_scalar(complex) || is_array(complex) {
            let operand = new Complex(complex);
            return operand;
        } elseif !is_object(complex) || !(complex instanceof Complex) {
            throw new \Exception("COMPLEX: Value \"" . complex . "\" is not a valid complex number");
        }

        return complex;
    }

    /**
     * Adds a value to this complex number, modifying the value of this instance
     *
     * @param    string|integer|float|Complex    $complex   The number to add
     * @return   Complex
     */
    public function add(complex = 0)
    {
        var operand;

        let operand = this->validateComplexArgument(complex);

        let this->realPart = this->realPart + operand->getReal();
        let this->imaginaryPart = this->imaginaryPart + operand->getImaginary();

        return this;
    }

    /**
     * Subtracts a value from this complex number, modifying the value of this instance
     *
     * @param    string|integer|float|Complex    $complex   The number to subtract
     * @return   Complex
     */
    public function subtract(complex = 0)
    {
        var operand;

        let operand = this->validateComplexArgument(complex);
        let this->realPart = this->realPart - operand->getReal();
        let this->imaginaryPart = this->imaginaryPart - operand->getImaginary();

        return this;
    }

    /**
     * Multiplies this complex number by a value, modifying the value of this instance
     *
     * @param    string|integer|float|Complex    $complex   The number to multiply by
     * @return   Complex
     */
    public function multiply(complex = 1)
    {
        var operand, realPart, imaginaryPart;

        let operand = this->validateComplexArgument(complex);
        let realPart = this->getReal() * operand->getReal() - this->getImaginary() * operand->getImaginary();
        let imaginaryPart = this->getReal() * operand->getImaginary() + this->getImaginary() * operand->getReal();
        let this->realPart = realPart;
        let this->imaginaryPart = imaginaryPart;

        return this;
    }

    /**
     * Divides this complex number by a value, modifying the value of this instance
     *
     * @param    string|integer|float|Complex    $complex   The number to divide by
     * @return   Complex
     * @throws   \InvalidArgumentException       If function would result in a division by zero
     */
    public function divideBy(complex = 1)
    {
        var operand, delta1, delta2, delta3;

        let operand = this->validateComplexArgument(complex);

        if operand->getReal() == 0.0 && operand->getImaginary() == 0.0 {
            throw new \InvalidArgumentException("Division by zero");
        }
        let delta1 = this->getReal() * operand->getReal() + this->getImaginary() * operand->getImaginary();
        let delta2 = this->getImaginary() * operand->getReal() - this->getReal() * operand->getImaginary();
        let delta3 = operand->getReal() * operand->getReal() + operand->getImaginary() * operand->getImaginary();
        let this->realPart = delta1 / delta3;
        let this->imaginaryPart = delta2 / delta3;

        return this;
    }

    /**
     * Divides this complex number into a value, modifying the value of this instance
     *
     * @param    string|integer|float|Complex    $complex   The number to divide into
     * @return   Complex
     * @throws   \InvalidArgumentException       If function would result in a division by zero
     */
    public function divideInto(complex = 1)
    {
        var operand, delta1, delta2, delta3;

        if this->getReal() == 0 && this->getImaginary() == 0 {
            throw new \InvalidArgumentException("Division by zero");
        }

        let operand = this->validateComplexArgument(complex);
        let delta1 = operand->getReal() * this->getReal() + operand->getImaginary() * this->getImaginary();
        let delta2 = operand->getImaginary() * this->getReal() - operand->getReal() * this->getImaginary();
        let delta3 = this->getReal() * this->getReal() + this->getImaginary() * this->getImaginary();
        let this->realPart = delta1 / delta3;
        let this->imaginaryPart = delta2 / delta3;

        return this;
    }
}
