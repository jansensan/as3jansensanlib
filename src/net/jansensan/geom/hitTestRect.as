package net.jansensan.geom
{
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * Tests if a point is inside a rectangle.
	 * 
	 * @param point The point to test.
	 * @param rect The rectangle in which to test the point.
	 * 
	 * @return		Returns <code>true</code> or <code>false</code> depending if the point is inside the rectangle.
	 */
	public function hitTestRect	(	point:Point, 
									rect:Rectangle
								):Boolean
	{
		var isHit:Boolean = false;
		if	(	point.x >= rect.x
				&& point.x <= rect.x + rect.width
				&& point.y >= rect.y
				&& point.y <= rect.y + rect.height
			)
		{
			isHit = true;
		}
		return isHit;
	}
}
