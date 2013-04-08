package net.jansensan.utils
{
	/**
	 * @param numerator The numerator to reduce.
	 * @param denominator The denominator to reduce.
	 * 
	 * @return Array An array that contains the reduced numerator at index 0, and the reduced denominator at index 1.
	 * 
	 * @author Mat Janson Blanchet
	 */
	public function getReducedRatio(numerator:uint, denominator:uint):Array
	{
		var greatestCommonFactor:uint;
		var reducedNumerator:uint;
		var reducedDenominator:uint;
		for(var i:uint = 1; (i < numerator) || (i == numerator); i++)
		{
			if(numerator % i == 0)
			{
				for(var j:uint = 1; (j < denominator) || (j == denominator); j++)
				{
					if(denominator % j == 0)
					{
						if(i == j)
						{
							greatestCommonFactor = Math.max(i, j);
						}
						reducedNumerator = numerator / greatestCommonFactor;
						reducedDenominator = denominator / greatestCommonFactor;
					}
				}
			}
		}
		return [reducedNumerator, reducedDenominator];
	}
}
