package net.jansensan.utils
{
	/**
	 * Calculates how many frames happen during a certain elapsed duration.
	 * 
	 * @param	duration	The duration into which calculate how many frames happen, in milliseconds.
	 * @param	fps			The frames per seconds.
	 * 
	 * @return				The number of frames that happen during the given time.
	 */
	public function getNumFramesFromFPS(duration:uint, fps:uint = 60):uint
	{
		var frameDuration:uint = 1000 / fps;
		return uint(duration / frameDuration);
	}
}
