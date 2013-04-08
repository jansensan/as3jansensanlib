package net.jansensan.geom
{
	import flash.geom.Point;


	/**
	 * Tests if a point is inside a circle.
	 * 
	 * @param point The point to test.
	 * @param center The center point of the circle.
	 * @param radius The radius of the circle
	 * 
	 * @return Returns <code>true</code> or <code>false</code> depending if the point is inside the circle.
	 */
	public function hitTestCircle	(	point:Point, 
										center:Point, 
										radius:Number
									):Boolean
	{
		var dx:Number = point.x - center.x;
		var dy:Number = point.y - center.y;
		
		var isHit:Boolean = Math.sqrt(dx * dx + dy * dy) <= radius;
		return isHit;
	}
}
