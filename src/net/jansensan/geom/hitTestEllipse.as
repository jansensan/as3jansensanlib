package net.jansensan.geom
{
	import flash.geom.Rectangle;
	import flash.geom.Point;


	/**
	 * Tests if a point is inside an ellipse.
	 * 
	 * @param point The point to test.
	 * @param center The center point of the ellipse.
	 * @param ellipse A rectangle with the dimensions of the ellipse.
	 * 
	 * @return		Returns <code>true</code> or <code>false</code> depending if the point is inside the ellipse.
	 */
	public function hitTestEllipse	(	point:Point, 
										center:Point, 
										ellipse:Rectangle
									):Boolean
	{
		var dx:Number = point.x - center.x;
		var dy:Number = point.y - center.y;
		var rx:Number = ellipse.width * 0.5;
		var ry:Number = ellipse.height* 0.5;
		
		var isHit:Boolean = Math.sqrt((dx * dx) / (rx * rx) + (dy * dy) / (ry * ry)) <= 1;
		return isHit;
	}
}
