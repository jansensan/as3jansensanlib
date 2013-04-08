package net.jansensan.utils
{
	/**
	 * Converts given RGB values into hex value (<code>uint</code>).
	 * 
	 * @param	r	The red value, in a range of 0 to 255.
	 * @param	g	The green value, in a range of 0 to 255.
	 * @param	b	The blue value, in a range of 0 to 255.
	 * 
	 * @return		Returns a generic <code>Object</code> representing the RGB values calculated from the provided hex value. 
	 * 				Values can be accessed with the properties <code>r</code>, <code>g</code> and <code>b</code> on the returned <code>Object</code>. 
	 * 				For example, <code>trace(getRGBFromHex(0xaabbcc).r, getRGBFromHex(0xaabbcc).g, getRGBFromHex(0xaabbcc).b); // traces 170 187 204</code>
	 */
	public function getRGBFromHex(hex:uint):Object
	{
		var rgb:Object = {};
		rgb.r = uint("0x" + hex.toString(16).substr(0, 2).toUpperCase());
		rgb.g = uint("0x" + hex.toString(16).substr(2, 2).toUpperCase());
		rgb.b = uint("0x" + hex.toString(16).substr(4, 2).toUpperCase());
		return rgb;
	}
}