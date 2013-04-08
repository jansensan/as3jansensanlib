package net.jansensan.utils
{
	/**
	 * Converts radians into degrees.
	 * 
	 * @param radians	The value to convert into degrees.
	 * 
	 * @return			Radians converted into degrees.
	 */
	public function radiansToDegrees(radians:Number):Number
	{
		return radians * (180 / Math.PI);
	}
}
