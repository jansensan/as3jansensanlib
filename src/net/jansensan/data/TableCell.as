package net.jansensan.data
{
	/**
	 * @author Mat Janson Blanchet
	 */
	public class TableCell
	{
		public	var	row		:int;
		public	var	column	:int;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function toString():String
		{
			return '(column=' + column + ', row=' + row + ')';
		}
	}
}
