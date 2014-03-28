package net.jansensan.geom
{
	/**
	 * <p>When using multiple devices, it may be unadvised to use preset pixel dimensions for UI elements, 
	 * since each device has different resolutions and pixel density.</p>
	 * 
	 * <p>It is then ideal to find a dimension that can represent the size of a finger on the display support. 
	 * Apple chose a fixed dimension in pixels, although that works only for their devices.</p>
	 * 
	 * <p>This function returns the ideal size of the edge of a square that a finger would cover 
	 * with a given pixel density (PPI).</p>
	 * 
	 * @param ppi The pixel density (PPI) of the device or display support.
	 * 
	 * @return Returns the ideal size of the edge of a square that a finger covers with the given pixel density (PPI).
	 */
	public function getFingerSize(ppi:uint):uint
	{
		// The BlackBerry 10 OS uses a ratio around 4/15
		// Apple suggests 44 px, which makes for a 44/163 ratio
		
		// this is a good average
		return Math.round((66 / 245) * ppi);
	}
}
