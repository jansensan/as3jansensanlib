package net.jansensan.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * @author Mat Janson Blanchet
	 */
	public class Image extends Sprite
	{
		private	var	_originalDimensions	:Rectangle;
		
		private	var	_image				:Bitmap;
		private	var	_mask				:Shape;
		
		private	var	_fitting			:String;
		private	var	_alignment			:String;
		
		private	var	_width				:int;
		private	var	_height				:int;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function Image	(	bitmapData:BitmapData,
									fitting:String = ImageFitting.FIT_CONTENT_PROPORTIONALLY,
									alignment:String = ImageAlignment.CENTER,
									width:int = 100,
									height:int = 100
								)
		{
			// set params to member vars
			if(!bitmapData)
			{
				throw new IllegalOperationError("The bitmapData argument cannot be null. Please provide a valid BitmapData.");
			}
			_originalDimensions = new Rectangle(0, 0, bitmapData.width, bitmapData.height);
			
			_width = width;
			_height = height;
			
			setFitting(fitting);
			setAlignment(alignment);
			
			// display objects
			_mask = new Shape();
			setMask();
			
			_image = new Bitmap();
			_image.smoothing = true;
			_image.bitmapData = bitmapData;
			_image.mask = _mask;
			fitImage();
			alignImage();
			
			addChild(_image);
			addChild(_mask);
		}


		private function setFitting(type:String):void
		{
			switch(type)
			{
				case ImageFitting.FIT_CONTENT_PROPORTIONALLY:
				case ImageFitting.FILL_FRAME_PROPORTIONALLY:
				case ImageFitting.FILL_FRAME:
				case ImageFitting.NONE:
					_fitting = type;
					break;
				
				default:
					var error:IllegalOperationError = new IllegalOperationError();
					error.message = "The fitting type you have set ('" + type + "') is not supported. Please look at net.jansensan.display.ImageFitting for supported types.";
					throw error;
			}
		}


		private function setAlignment(type:String):void
		{
			switch(type)
			{
				case ImageAlignment.TOP_LEFT:
				case ImageAlignment.TOP_CENTER:
				case ImageAlignment.TOP_RIGHT:
				case ImageAlignment.LEFT:
				case ImageAlignment.CENTER:
				case ImageAlignment.RIGHT:
				case ImageAlignment.BOTTOM_LEFT:
				case ImageAlignment.BOTTOM_CENTER:
				case ImageAlignment.BOTTOM_RIGHT:
					_alignment = type;
					break;
				
				default:
					var error:IllegalOperationError = new IllegalOperationError();
					error.message = "The alignment type you have set ('" + type + "') is not supported. Please look at net.jansensan.display.ImageAlignment for supported types.";
					throw error;
			}
		}


		private function setMask():void
		{
			_mask.graphics.clear();
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
		}


		private function fitImage():void
		{
			var dimensions:Rectangle = new Rectangle();
			var ratio:Number = _originalDimensions.height / _originalDimensions.width;
			
			switch(_fitting)
			{
				case ImageFitting.FIT_CONTENT_PROPORTIONALLY:
					dimensions.width = _width;
					dimensions.height = int(_width * ratio);
					
					// check that the height of the image does not exceed the height of the mask
					if(dimensions.height > _height)
					{
						dimensions.height = _height;
						dimensions.width = int(_width / ratio);
					}
					break;
				
				case ImageFitting.FILL_FRAME_PROPORTIONALLY:
					dimensions.width = _width;
					dimensions.height = int(_width * ratio);
					
					// check that there is no empty space
					if(dimensions.height < _height)
					{
						dimensions.height = _height;
						dimensions.width = int(_width / ratio);
					}
					break;
				
				case ImageFitting.FILL_FRAME:
					dimensions.width = _width;
					dimensions.height = _height;
					break;
				
				case ImageFitting.NONE:
					dimensions.width = _originalDimensions.width;
					dimensions.height = _originalDimensions.height;
					break;
			}
			_image.width = dimensions.width;
			_image.height = dimensions.height;
		}


		private function alignImage():void
		{
			var location:Point = new Point();
			switch(_alignment)
			{
				case ImageAlignment.TOP_LEFT:
					location.x = 0;
					location.y = 0;
					break;
				
				case ImageAlignment.TOP_CENTER:
					location.x = getCenterX();
					location.y = 0;
					break;
				
				case ImageAlignment.TOP_RIGHT:
					location.x = getRightX();
					location.y = 0;
					break;
				
				case ImageAlignment.LEFT:
					location.x = 0;
					location.y = getCenterY();
					break;
				
				case ImageAlignment.CENTER:
					location.x = getCenterX();
					location.y = getCenterY();
					break;
				
				case ImageAlignment.RIGHT:
					location.x = getRightX();
					location.y = getCenterY();
					break;
				
				case ImageAlignment.BOTTOM_LEFT:
					location.x = 0;
					location.y = getBottomY();
					break;
				
				case ImageAlignment.BOTTOM_CENTER:
					location.x = getCenterX();
					trace("\t", "location.x: " + (location.x));
					location.y = getBottomY();
					break;
				
				case ImageAlignment.BOTTOM_RIGHT:
					location.x = getRightX();
					trace("\t", "location.x: " + (location.x));
					location.y = getBottomY();
					break;
			}
			_image.x = location.x;
			_image.y = location.y;
		}


		private function getCenterX():int
		{
			var centerX:int = int(_width * 0.5 - _image.width * 0.5);
			return centerX;
		}


		private function getRightX():int
		{
			var rightX:int = int(_width - _image.width);
			return rightX;
		}


		private function getCenterY():int
		{
			var centerY:int = int(_height * 0.5 - _image.height * 0.5);
			return centerY;
		}


		private function getBottomY():int
		{
			var bottomY:int = int(_height - _image.height);
			return bottomY;
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		override public function set width(value:Number):void
		{
			_width = value;
			fitImage();
			alignImage();
		}


		override public function get width():Number
		{
			return _width;
		}


		override public function set height(value:Number):void
		{
			_height = value;
			fitImage();
			alignImage();
		}


		override public function get height():Number
		{
			return _height;
		}


		public function get fitting():String
		{
			return _fitting;
		}


		public function set fitting(fitting:String):void
		{
			_fitting = fitting;
			fitImage();
			alignImage();
		}


		public function get alignment():String
		{
			return _alignment;
		}


		public function set alignment(alignment:String):void
		{
			_alignment = alignment;
			fitImage();
			alignImage();
		}


		public function set bitmapData(value:BitmapData):void
		{
			_image.bitmapData = value;
			_image.smoothing = true;
			
			_originalDimensions.width = value.width;
			_originalDimensions.height = value.height;
			
			fitImage();
			alignImage();
		}


		public function get visibleDimensions():Rectangle
		{
			var rect:Rectangle = new Rectangle();
			
			rect.x = _image.x;
			if(rect.x < 0) rect.x = 0;
			
			rect.y = _image.y;
			if(rect.y < 0) rect.y = 0;
			
			rect.width = _image.width;
			if(rect.width > _width) rect.width = _width;
			
			rect.height = _image.height;
			if(rect.height > _height) rect.height = _height;
			
			return rect;
		}
	}
}
