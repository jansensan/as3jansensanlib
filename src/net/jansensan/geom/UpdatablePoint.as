package net.jansensan.geom
{
	import flash.geom.Point;


	/**
	 * A point that is made to be updated. Keeps track of the previous location as well as the delta of the previous location compared to the actual one. 
	 * 
	 * @author Mat Janson Blanchet
	 */
	public class UpdatablePoint
	{
		private	var	_currentLocation	:Point;
		private	var	_previousLocation	:Point;
		private	var	_delta				:Point;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		/**
		 * A point that is made to be updated. Keeps track of the previous location as well as the delta of the previous location compared to the actual one. 
		 * <p>Eventually, more functions from the <code>Point</code> class will be mirrored in this class.</p>
		 * 
		 * @param	x	The initial X location of the point
		 * @param	y	The initial X location of the point
		 */
		public function UpdatablePoint(x:Number = 0, y:Number = 0)
		{
			_previousLocation = new Point(x, y);
			_currentLocation = new Point(x, y);
			setDelta();
		}


		public function toPoint():Point
		{
			return _currentLocation;
		}


		public function toString():String
		{
			return "[UpdatablePoint x=" + _currentLocation.x + ", y=" + _currentLocation.y + ", previousX=" + _previousLocation.x + ", previousY=" + _previousLocation.y + ", deltaX=" + _delta.x + ", deltaY=" + _delta.y + "]";
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		private function setDelta():void
		{
			if(!_delta) _delta = new Point();
			_delta.x = _currentLocation.x - _previousLocation.x;
			_delta.y = _currentLocation.y - _previousLocation.y;
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function get x():Number
		{
			return _currentLocation.x;
		}


		public function set x(x:Number):void
		{
			_previousLocation.x = _currentLocation.x;
			_currentLocation.x = x;
			setDelta();
		}


		public function get y():Number
		{
			return _currentLocation.y;
		}


		public function set y(y:Number):void
		{
			_previousLocation.y = _currentLocation.y;
			_currentLocation.y = y;
			setDelta();
		}


		public function get previousLocation():Point
		{
			return _previousLocation;
		}


		public function get previousX():Number
		{
			return _previousLocation.x;
		}


		public function get previousY():Number
		{
			return _previousLocation.y;
		}


		public function get delta():Point
		{
			return _delta;
		}


		public function get deltaX():Number
		{
			return _delta.x;
		}


		public function get deltaY():Number
		{
			return _delta.y;
		}


		public function get length():Number
		{
			return _currentLocation.length;
		}


	}
}