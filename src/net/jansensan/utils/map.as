package net.jansensan.utils
{
	/**
	 * Allows to map a number to another.
	 * 
	 * @param numberToMap		The number to map to another.
	 * @param minValue			The minimum value that the input numberToMap argument can have. If the value of the argument is lower, it will be set to minValue.
	 * @param maxValue			The maximum value that the input numberToMap argument can have. If the value of the argument is higher, it will be set to minValue.
	 * @param minMappedValue	The minimum value the output can have.
	 * @param maxMappedValue	The maximum value the output can have.
	 * 
	 * @return					The input value mapped to the desired new value.
	 */
	public function map	(	numberToMap:Number,
							minValue:Number,
							maxValue:Number,
							minMappedValue:Number,
							maxMappedValue:Number
						):Number
	{
		if(numberToMap < minValue)
		{
			numberToMap = minValue;
		}
		else if(numberToMap > maxValue)
		{
			numberToMap = maxValue;
		}
		var numSteps:Number = maxValue - minValue;
		var numMappedSteps:Number = maxMappedValue - minMappedValue;
		var normalizedNumber:Number = numberToMap - minValue;
		var ratio:Number = normalizedNumber / numSteps;
		var scaledValue:Number = minMappedValue + (ratio * numMappedSteps);
		return scaledValue;
	}
}
