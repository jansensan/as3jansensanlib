package net.jansensan.mvc.events
{
	import net.jansensan.event.AbstractDataEvent;

	import flash.events.Event;
	
	
	/**
	 * @author Mat Janson Blanchet
	 */
	public class ViewEvent extends AbstractDataEvent
	{
		// + ----------------------------------------
		//		[ CONSTANTS ]
		// + ----------------------------------------
		
		public	static	const	CLICK			:String = "CLICK";
		public	static	const	CLOSE			:String = "CLOSE";
		public	static	const	DOUBLE_CLICK	:String = "DOUBLE_CLICK";
		public	static	const	DRAG_START		:String = "DRAG_START";
		public	static	const	DRAG_STOP		:String = "DRAG_STOP";
		public	static	const	DRAG_UP			:String = "DRAG_UP";
		public	static	const	DRAG_DOWN		:String = "DRAG_DOWN";
		public	static	const	HIDE_COMPLETE	:String = "HIDE_COMPLETE";
		public	static	const	MOUSE_DOWN		:String = "MOUSE_DOWN";
		public	static	const	MOUSE_UP		:String = "MOUSE_UP";
		public	static	const	MOUSE_OVER		:String = "MOUSE_OVER";
		public	static	const	MOUSE_OUT		:String = "MOUSE_OUT";
		public	static	const	ROLL_OVER		:String = "ROLL_OVER";
		public	static	const	ROLL_OUT		:String = "ROLL_OUT";
		public	static	const	SHOW_COMPLETE	:String = "SHOW_COMPLETE";
		public	static	const	STATE_CHANGE	:String = "STATE_CHANGE";
		public	static	const	UPDATE			:String = "UPDATE";
		
		
		// + ----------------------------------------
		//		[CONSTRUCTOR ]
		// + ----------------------------------------
		
		public function ViewEvent	(	type:String,
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
			return new ViewEvent(type, bubbles, cancelable, _data);
		}
		
		
	}
}