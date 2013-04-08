package net.jansensan.utils
{
	/**
	 * Converts given RGB values into hex value (<code>uint</code>).
	 * 
	 * @param	r	The red value, in a range of 0 to 255.
	 * @param	g	The green value, in a range of 0 to 255.
	 * @param	b	The blue value, in a range of 0 to 255.
	 * 
	 * @return		Returns a hex value (<code>uint</code>) with the given RGB values.
	 */
	public function getHexFromRGB(r:uint, g:uint, b:uint):uint
	{
		if(r > 255)
		{
			throw new Error("The red value provided (" + r + ") exceeds the maximum value allowed (255)");
		}
		if(g > 255)
		{
			throw new Error("The green value provided (" + g + ") exceeds the maximum value allowed (255)");
		}
		if(b > 255)
		{
			throw new Error("The red value provided (" + b + ") exceeds the maximum value allowed (255)");
		}
		var hex:uint = r << 16 | g << 8 | b;
		return hex;
	}
}
