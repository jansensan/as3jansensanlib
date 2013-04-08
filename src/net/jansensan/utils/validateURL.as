package net.jansensan.utils
{
	/**
	 * Validates an URL with a regular expression.
	 * <p>Expression obtained from <a href="http://englishblog.flepstudio.org/tutorials/flash-cs3/sintax/useful-list-of-regular-expressions-with-actionscript-3-regexp-class/">here</a>.</p>
	 * 
	 * @param	url	The string to validate
	 * 
	 * @return	Whether or not the string is a valid URL.
	 */
	public function validateURL(url:String):Boolean
	{
		var validURLRegExp:RegExp = /^http(s)?:\/\/((\d+\.\d+\.\d+\.\d+)|(([\w-]+\.)+([a-z,A-Z][\w-]*)))(:[1-9][0-9]*)?(\/([\w-.\/:%+@&=]+[\w- .\/?:%+@&=]*)?)?(#(.*))?$/i;
		return validURLRegExp.test(url);
	}
}
