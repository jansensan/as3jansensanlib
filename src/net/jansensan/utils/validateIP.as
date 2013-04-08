package net.jansensan.utils
{
	/**
	 * Validates an IP adress with a regular expression.
	 * <p>Expression obtained from <a href="http://englishblog.flepstudio.org/tutorials/flash-cs3/sintax/useful-list-of-regular-expressions-with-actionscript-3-regexp-class/">here</a>.</p>
	 * 
	 * @param	ip	The string to validate
	 * 
	 * @return	Whether or not the string is a valid IP address.
	 */
	public function validateIP(ip:String):Boolean
	{
		var validIPRegExp:RegExp= /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))*$/;
		return validIPRegExp.test(ip);
	}
}
