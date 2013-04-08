package net.jansensan.utils
{
	/**
	 * Converts a value in Celsius to Fahrenheit.
	 * 
	 * @param celsius The value in Celsius to be converted in Fahrenheit.
	 * 
	 * @return The Celsius value converted in Fahrenheit.
	 * 
	 * @see http://www.wikipedia.org/wiki/Celsius
	 */
	public function celsiusToFahrenheit(celsius:Number):Number
	{
		return (celsius * (9 / 5)) + 32;
	}
}
