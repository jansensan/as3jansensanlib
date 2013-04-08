package net.jansensan.event
{
	import flash.events.Event;


	/**
	 * @author Mat Janson Blanchet
	 */
	public class AbstractDataEvent extends Event
	{
		/**
		 * @private
		 */
		protected	var	_data	:Object;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function AbstractDataEvent	(	type:String,
												bubbles:Boolean = false,
												cancelable:Boolean = false,
												data:Object = null
											)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}


		public override function clone():Event
		{
			return new AbstractDataEvent(type, bubbles, cancelable, _data);
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function set data(value:Object):void
		{
			_data = value;
		}


		public function get data():Object
		{
			return _data;
		}


	}
}