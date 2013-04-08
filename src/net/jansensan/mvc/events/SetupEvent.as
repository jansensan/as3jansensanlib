package net.jansensan.mvc.events
{
	import net.jansensan.event.AbstractDataEvent;

	import flash.events.Event;
	
	
	/**
	 * @author Mat Janson Blanchet
	 */
	public class SetupEvent extends AbstractDataEvent
	{
		// + ----------------------------------------
		//		[ CONSTANTS ]
		// + ----------------------------------------
		
		public	static	const	ROOT_VIEW_ADDED			:String = "ROOT_VIEW_ADDED";
		public	static	const	CONFIG_MODEL_READY		:String = "CONFIG_MODEL_READY";
		public	static	const	BASIC_UI_ADDED			:String = "BASIC_UI_ADDED";
		public	static	const	ASSETS_LOAD_PROGRESS	:String = "ASSETS_LOAD_PROGRESS";
		public	static	const	ASSETS_LOAD_COMPLETE	:String = "ASSETS_LOAD_COMPLETE";
		public	static	const	PRELOADER_ANIM_COMPLETE	:String = "PRELOADER_ANIM_COMPLETE";
		
		
		// + ----------------------------------------
		//		[CONSTRUCTOR ]
		// + ----------------------------------------
		
		public function SetupEvent	(	type:String,
										bubbles:Boolean = false,
										cancelable:Boolean = false,
										data:Object = null
									)
		{
			super(type, bubbles, cancelable, data);
		}
		
		
		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------
		
		public override function clone():Event
		{
			return new SetupEvent(type, bubbles, cancelable, _data);
		}
		
		
	}
}