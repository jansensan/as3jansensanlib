package net.jansensan.geom
{


	/**
	 * @author Mat Janson Blanchet
	 */
	public class Margin
	{
		private	var	_top	:Number;
		private	var	_right	:Number;
		private	var	_bottom	:Number;
		private	var	_left	:Number;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function Margin	(	top:Number = 0,
									right:Number = 0,
									bottom:Number = 0,
									left:Number = 0
								)
		{
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}


		public function toString():String
		{
			return '[Margin top=' + _top + ' right=' + _right + ' bottom=' + _bottom + ' left=' + _left + ']';
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function get top():Number
		{
			return _top;
		}


		public function set top(top:Number):void
		{
			_top = top;
		}


		public function get right():Number
		{
			return _right;
		}


		public function set right(right:Number):void
		{
			_right = right;
		}


		public function get bottom():Number
		{
			return _bottom;
		}


		public function set bottom(bottom:Number):void
		{
			_bottom = bottom;
		}


		public function get left():Number
		{
			return _left;
		}


		public function set left(left:Number):void
		{
			_left = left;
		}
	}
}
