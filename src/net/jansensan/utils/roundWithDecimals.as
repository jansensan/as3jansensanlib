package net.jansensan.utils
{
	/**
	 * Rounds a <code>NUmber</code> with the specified amount of decimals
	 * 
	 * @param num The <code>NUmber</code> to round.
	 * @param precision The amount of decimals desired.
	 * 
	 * @return The rounded value.
	 * 
	 * @see http://swordfish1987.wordpress.com/2009/07/10/decimal-rounding-in-actionscript-3/
	 */
	public function roundWithDecimals(num:Number, precision:uint):Number
	{
		var decimal:Number = Math.pow(10, precision);
		return Math.round(decimal * num) / decimal;
	}
}
