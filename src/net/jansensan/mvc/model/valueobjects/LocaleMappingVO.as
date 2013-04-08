package net.jansensan.mvc.model.valueobjects
{
	/**
	 * A value object useful when dealing with localization.
	 * 
	 * @author Mat Janson Blanchet
	 */
	public class LocaleMappingVO
	{
		// + ----------------------------------------
		//		[ VARIABLES ]
		// + ----------------------------------------
		
		private	var	_country	:String;
		private	var	_language	:String;
		private	var	_alphabet	:String;
		
		
		// + ----------------------------------------
		//		[CONSTRUCTOR ]
		// + ----------------------------------------
		
		public function LocaleMappingVO	(	country:String,
											language:String,
											alphabet:String
										)
		{
			_country = country;
			_language = language;
			_alphabet = alphabet;
		}
		
		
		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------
		
		public function get country():String
		{
			return _country;
		}
		
		
		public function get language():String
		{
			return _language;
		}
		
		
		public function get alphabet():String
		{
			return _alphabet;
		}
		
		
	}
}