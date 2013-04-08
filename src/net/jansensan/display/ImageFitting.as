package net.jansensan.display
{
	/**
	 * @author Mat Janson Blanchet
	 */
	public class ImageFitting
	{
		/**
		 * No special type of fitting. Image will be left untouched
		 */
		public	static	const	NONE						:String = "none";
		
		/**
		 * Image will be resized proportionally to be fully visible within the frame. Empty space will be visible.
		 */
		public	static	const	FIT_CONTENT_PROPORTIONALLY	:String = "fit content proportionally";
		
		/**
		 * Image will be resized proportionally to fit the frame, no empty space will be visible.
		 */
		public	static	const	FILL_FRAME_PROPORTIONALLY	:String = "fill frame proportionally";
		
		/**
		 * Image will be resized to be fully visible within the frame. Empty space will be visible.
		 */
		public	static	const	FILL_FRAME	:String = "fill frame";
	}
}
