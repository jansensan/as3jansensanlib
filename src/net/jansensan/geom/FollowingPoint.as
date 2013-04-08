package net.jansensan.geom
{
	import flash.geom.Point;


	/**
	 * @author Mat Janson Blanchet
	 */
	public class FollowingPoint extends UpdatablePoint
	{
		private	var	_ease		:Number = 100;
		private	var	_friction	:Number = 0.9;
		private	var	_velocity	:Point;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------
		
		public function FollowingPoint	(	x:Number = 0, 
											y:Number = 0, 
											ease:Number = 100, 
											friction:Number = 0.9
										)
		{
			super(x, y);
			_ease = ease;
			_friction = friction;
			_velocity = new Point();
		}


		public function setTarget(target:Point):void
		{
			_velocity.x += (target.x - x) / _ease;
			_velocity.y += (target.y - y) / _ease;
			_velocity.x *= _friction;
			_velocity.y *= _friction;
			
			update();
		}


		public function update():void
		{
			x += _velocity.x;
			y += _velocity.y;
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function get ease():Number
		{
			return _ease;
		}


		public function set ease(ease:Number):void
		{
			_ease = ease;
		}


		public function get friction():Number
		{
			return _friction;
		}


		public function set friction(friction:Number):void
		{
			_friction = friction;
		}
	}
}
