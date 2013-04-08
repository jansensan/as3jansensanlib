package net.jansensan.utils
{
	/**
	 * Returns <code>true</code> or <code>false</code> depending on the odds.
	 * 
	 * @param odds	A number that represents the chance of obtaining <code>true</code> as a result. Anything under 0 is normalized to 0, anything over 1 is normalized to 1.
	 * 
	 * @return		Returns <code>true</code> or <code>false</code> depending on the odds.
	 */
	public function gamble(odds:Number):Boolean
	{
		if(odds < 0) odds = 0;
		if(odds > 1) odds = 1;
		return (Math.random() <= odds);
	}
}
