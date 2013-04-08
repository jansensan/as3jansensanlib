package net.jansensan.display
{
	import flash.display.DisplayObject;
	/**
	 * @author Mat Janson Blanchet
	 */
	public class DisplayObjectPool
	{
		private	var	_pool		:Array;
		private	var	_counter	:int;


		public function DisplayObjectPool(type:Class, length:int)
		{
			// reference: http://www.gotoandlearn.com/play.php?id=160
			_pool = [];
			_counter = length;
			
			var i:int = length;
			while(--i > -1)
			{
				_pool[i] = new type();
			}
		}


		public function getItem():DisplayObject
		{
			var item:DisplayObject;
			if(_counter > 0)
			{
				item =  _pool[--_counter];
			}
			return item;
		}


		public function returnItem(item:DisplayObject):void
		{
			_pool[_counter++] = item;
		}
	}
}