package net.jansensan.event
{
	import flash.events.Event;


	/**
	 * @author Mat Janson Blanchet
	 */
	public class LoaderEvent extends AbstractDataEvent
	{
		// + ----------------------------------------
		//		[ CONSTANTS ]
		// + ----------------------------------------

		public	static	const	PROGRESS		:String = "PROGRESS";
		public	static	const	READY			:String = "READY";
		public	static	const	LOADING_ABORTED	:String = "LOADING_ABORTED";
		public	static	const	LOADER_KILLED	:String = "LOADER_KILLED";
		public	static	const	LOADER_ERROR	:String = "LOADER_ERROR";


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function LoaderEvent	(	type:String,
										bubbles:Boolean = false,
										cancelable:Boolean = false,
										data:Object = null
									)
		{
			super(type, bubbles, cancelable, data);
		}


		public override function clone():Event
		{
			return new LoaderEvent(type, bubbles, cancelable, _data);
		}


	}
}