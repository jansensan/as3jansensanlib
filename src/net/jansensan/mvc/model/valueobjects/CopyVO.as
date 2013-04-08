package net.jansensan.mvc.model.valueobjects
{
	import flash.utils.Dictionary;
	
	
	/**
	 * @author Mat Janson Blanchet
	 */
	public class CopyVO
	{
		private	var	_id		:String;
		private	var	_copy	:Dictionary;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function CopyVO(id:String)
		{
			_id = id;
			_copy = new Dictionary();
		}


		public function setCopy	(	language:String,
									copy:String
								):void
		{
			_copy[language] = copy;
		}


		public function toString():String
		{
			return '[CopyVO id="' + _id + '" ]';
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function get id():String
		{
			return _id;
		}


		public function get copy():Dictionary
		{
			return _copy;
		}

	}
}
