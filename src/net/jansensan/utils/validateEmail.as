package net.jansensan.utils
{
	/**
	 * Validates an email adress with a regular expression.
	 * <p>Expression obtained from <a href="http://englishblog.flepstudio.org/tutorials/flash-cs3/sintax/useful-list-of-regular-expressions-with-actionscript-3-regexp-class/">here</a>.</p>
	 * 
	 * @param	email	The string to validate
	 * 
	 * @return	Whether or not the string is a valid email address.
	 */
	public function validateEmail(email:String):Boolean
	{
		var validEmailRegExp:RegExp = /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})*$/;
		return validEmailRegExp.test(email);
	}
}
