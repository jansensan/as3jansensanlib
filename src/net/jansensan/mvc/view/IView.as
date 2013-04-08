package net.jansensan.mvc.view
{
	/**
	 * @author Mat Janson Blanchet
	 */
	public interface IView
	{
		function init():void;
		function show():void;
		function hide():void;
		function kill():void;
	}
}