package net.jansensan.utils
{
	/**
	 * Converts a value in Fahrenheit to Celsius.
	 * 
	 * @param fahrenheit The value in Fahrenheit to be converted in Celsius.
	 * 
	 * @return The Fahrenheit value converted in Celsius.
	 * 
	 * @see http://www.wikipedia.org/wiki/Fahrenheit
	 */
	public function fahrenheitToCelcius(fahrenheit:Number):Number
	{
		return (fahrenheit - 32) * (5 / 9);
	}
}
