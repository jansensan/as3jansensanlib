package net.jansensan.display
{
	import net.jansensan.mvc.view.IView;

	import flash.display.Sprite;


	/**
	 * @author Mat Janson Blanchet
	 */
	public class HitArea extends Sprite implements IView
	{
		private	var	_width			:int = 1;
		private	var	_height			:int = 1;
		private	var	_shape			:String = HitAreaShape.RECTANGLE;
		
		private	var	_hitArea		:Sprite;
		
		private	var	_isInit			:Boolean = false;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------
		
		public function HitArea()
		{
			super();
			init();
		}


		public function init():void
		{
			if(!_isInit)
			{
				_hitArea = new Sprite();
				_hitArea.alpha = 0;
				addChild(_hitArea);
			}
		}


		public function hide():void
		{
			_hitArea.alpha = 0;
		}


		public function show():void
		{
			_hitArea.alpha = 1;
		}


		public function kill():void
		{
			
		}


		// + ----------------------------------------
		//		[ PRIVATE METHODS ]
		// + ----------------------------------------
		
		private function draw():void
		{
			if(_hitArea)
			{
				_hitArea.graphics.clear();
				switch(_shape)
				{
					case HitAreaShape.RECTANGLE:
						_hitArea.graphics.beginFill(0x00ffff, 0.5);
						_hitArea.graphics.drawRect(0, 0, _width, _height);
						_hitArea.graphics.drawRect(1, 1, _width - 2, _height - 2);
						_hitArea.graphics.beginFill(0x81ffff, 0.5);
						_hitArea.graphics.drawRect(1, 1, _width - 2, _height - 2);
						break;
					
					case HitAreaShape.ELLIPSE:
						_hitArea.graphics.beginFill(0x00ffff, 0.5);
						_hitArea.graphics.drawEllipse(0, 0, _width, _height);
						_hitArea.graphics.drawEllipse(1, 1, _width - 2, _height - 2);
						_hitArea.graphics.beginFill(0x81ffff, 0.5);
						_hitArea.graphics.drawEllipse(1, 1, _width - 2, _height - 2);
						break;
				}
				_hitArea.graphics.endFill();
			}
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------
		
		override public function set width(value:Number):void
		{
			_width = value;
			draw();
		}


		override public function get width():Number
		{
			return _width;
		}


		override public function set height(value:Number):void
		{
			_height = value;
			draw();
		}


		override public function get height():Number
		{
			return _height;
		}


		public function get shape():String
		{
			return _shape;
		}


		public function set shape(shape:String):void
		{
			_shape = shape;
			draw();
		}
	}
}
