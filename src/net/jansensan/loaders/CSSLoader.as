package net.jansensan.loaders
{
	import net.jansensan.event.LoaderEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	
	/**
	 * <p>The <code>CSSLoader</code> class uses <code>flash.net.URLLoader</code> to specifically handle the loading of CSS files.</p>
	 * 
	 * <p><b>Usage:</b></p>
	 * 
	 * <pre>
	 * var cssLoader:CSSLoader;
	 * 
	 * function loadCSS():void
	 * {
	 * 	cssLoader = new CSSLoader();
	 * 	cssLoader.addEventListener(CSSLoader.PROGRESS, progressHandler);
	 * 	cssLoader.addEventListener(CSSLoader.READY, readyHandler);
	 * 	cssLoader.loadCSS("someCSSFile.css");
	 * }
	 * 
	 * function progressHandler():void
	 * {
	 * 	trace(cssLoader.loadedRatio);
	 * }
	 * 
	 * function readyHandler():void
	 * {
	 * 	// a good dev always removes event listeners
	 * 	cssLoader.removeEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	cssLoader.removeEventListener(LoaderEvent.READY, readyHandler);
	 * 	
	 * 	trace(cssLoader.loadedRatio);
	 * 	trace(cssLoader.styleSheet);
	 * }
	 * </pre>
	 * 
	 * @see flash.net.URLLoader
	 * @author Mat Janson Blanchet
	 */
	[Event(name="PROGRESS", type="net.jansensan.event.LoaderEvent")]
	[Event(name="READY", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADING_ABORTED", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADER_KILLED", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADER_ERROR", type="net.jansensan.event.LoaderEvent")]
	public class CSSLoader extends EventDispatcher
	{
		private	var	_url			:String;
		private	var	_loader			:URLLoader;
		private	var	_isLoading		:Boolean = false;
		private	var	_loadedRatio	:Number = 0;
		private	var	_styleSheet		:StyleSheet;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function CSSLoader()
		{
			super();
		}


		/**
		 * Initiates the loading of a CSS file.
		 * 
		 * @param	CSSURL	The path to the file, in <code>String</code> format. The <code>CSSLoader</code> will handle the conversion to <code>URLRequest</code>.
		 */
		public function load(url:String):void
		{
			_url = url;
			_loader = new URLLoader();
			addListeners();
			_loader.load(new URLRequest(_url));
			_isLoading = true;
		}


		/**
		 * Aborts the loading of the file.
		 */
		public function abortLoading():void
		{
			removeListeners();
			try
			{
				_loader.close();
			}
			catch(error:Error)
			{
				trace("\n", this, "--- abortLoading ---");
				trace(error.getStackTrace());
			}
			_isLoading = false;
			dispatchEvent(new LoaderEvent(LoaderEvent.LOADING_ABORTED));
		}


		/**
		 * Kills the loader, removing its internal event handlers and instances.
		 */
		public function kill():void
		{
			removeListeners();
			try
			{
				_loader.close();
			}
			catch(error:Error)
			{
				trace("\n", this, "--- kill ---");
				trace(error.getStackTrace());
			}
			_isLoading = false;
			_loader = null;
			dispatchEvent(new LoaderEvent(LoaderEvent.LOADER_KILLED));
		}


		// + ----------------------------------------
		//		[ PRIVATE/PROTECTED METHODS ]
		// + ----------------------------------------

		private function addListeners():void
		{
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.addEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.addEventListener(Event.COMPLETE, onLoaded);
		}


		private function removeListeners():void
		{
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.removeEventListener(Event.COMPLETE, onLoaded);
		}


		private function parseCSS():void
		{
			_styleSheet = new StyleSheet();
			_styleSheet.parseCSS(_loader.data);
		}


		// + ----------------------------------------
		//		[ EVENT HANDLERS ]
		// + ----------------------------------------

		private function onIOError(_:IOErrorEvent):void
		{
			trace("\n", this, "--- URLLoaderIOErrorHandler ---");
			trace("\t", "CSS URL:", _url);
			trace("\t", "event:", _);
			trace("\t", "event.text:", _.text);
			
			_isLoading = false;
			removeListeners();
			
			var ioErrorData:Object = {};
			ioErrorData.text = _.text;
			ioErrorData.errorID = _.errorID;
			
			var ioError:LoaderEvent = new LoaderEvent(LoaderEvent.LOADER_ERROR);
			ioError.data = ioErrorData;
			
			dispatchEvent(ioError);
		}


		private function onSecurityError(_:SecurityErrorEvent):void
		{
			trace("\n", this, "--- URLLoaderSecurityErrorHandler ---");
			trace("\t", "CSS URL:", _url);
			trace("\t", "event:", _);
			trace("\t", "event.text:", _.text);
			
			_isLoading = false;
			removeListeners();
			
			var securityErrorData:Object = {};
			securityErrorData.text = _.text;
			securityErrorData.errorID = _.errorID;
			
			var securityError:LoaderEvent = new LoaderEvent(LoaderEvent.LOADER_ERROR);
			securityError.data = securityErrorData;
			
			dispatchEvent(securityError);
		}


		private function onLoadHasProgressed(_:ProgressEvent):void
		{
			if(_.bytesTotal > 0) _loadedRatio = _.bytesLoaded / _.bytesTotal;
			dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS));
		}


		private function onLoaded(_:Event):void
		{
			_loadedRatio = 1;
			dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS));
			
			_isLoading = false;
			removeListeners();
			parseCSS();
			dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		/**
		 * Whether or not the loader is currently loading.
		 */
		public function get isLoading():Boolean
		{
			return _isLoading;
		}


		/**
		 * The loaded ratio of the file.
		 */
		public function get loadedRatio():Number
		{
			return _loadedRatio;
		}


		/**
		 * The <code>StyleSheet</code> class obtained from parsing the loaded CSS.
		 */
		public function get styleSheet():StyleSheet
		{
			return _styleSheet;
		}


		/**
		 * The URL of the file that is provided to the loader.
		 */
		public function get url():String
		{
			return _url;
		}


	}
}