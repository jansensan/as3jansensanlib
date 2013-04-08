package net.jansensan.loaders
{
	import net.jansensan.event.LoaderEvent;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;
	
	
	/**
	 * <p>The <code>SWFFontsLoader</code> class uses <code>flash.display.Loader</code> to specifically handle the loading of SWF files that contain embedded fonts.</p>
	 * <p>Fonts will be available to use in the whole application once the file is loaded, no need to retrieve any data from the <code>SWFFontsLoader</code>.</p>
	 * 
	 * <p><b>Usage:</b></p>
	 * 
	 * <pre>
	 * var swfFontsLoader:SWFFontsLoader;
	 * 
	 * function loadFonts():void
	 * {
	 * 	swfFontsLoader = new CSSLoader();
	 * 	swfFontsLoader.addEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	swfFontsLoader.addEventListener(LoaderEvent.READY, readyHandler);
	 * 	swfFontsLoader.loadCSS("someSWFFile.swf");
	 * }
	 * 
	 * function progressHandler():void
	 * {
	 * 	trace(swfFontsLoader.loadedRatio);
	 * }
	 * 
	 * function readyHandler():void
	 * {
	 * 	// a good dev always removes event listeners
	 * 	swfFontsLoader.removeEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	swfFontsLoader.removeEventListener(LoaderEvent.READY, readyHandler);
	 * 	
	 * 	trace(swfFontsLoader.loadedRatio);
	 * }
	 * </pre>
	 * 
	 * @see flash.display.Loader
	 * @author Mat Janson Blanchet
	 */
	[Event(name="PROGRESS", type="net.jansensan.event.LoaderEvent")]
	[Event(name="READY", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADING_ABORTED", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADER_KILLED", type="net.jansensan.event.LoaderEvent")]
	[Event(name="LOADER_ERROR", type="net.jansensan.event.LoaderEvent")]
	public class SWFFontsLoader extends EventDispatcher
	{
		private	var	_url			:String;
		private	var	_loader			:Loader;
		private	var	_isLoading		:Boolean = false;
		private	var	_loadedRatio	:Number = 0;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function SWFFontsLoader()
		{
			super();
		}


		/**
		 * Initiates the loading of an SWF file that should contain only embedded fonts.
		 * 
		 * @param	fontsSWFURL	The path to the file, in <code>String</code> format. The <code>SWFFontsLoader</code> will handle the conversion to <code>URLRequest</code>.
		 */
		public function load(url:String):void
		{
			_url = url;
			_loader = new Loader();
			addListeners();
			var URL:URLRequest = new URLRequest(_url);
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(URL, loaderContext);
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
		 * Traces all the fonts that are currently embedded and available in the current application domain.
		 */
		public function traceEmbeddedFonts():void
		{
			trace("\n", this, "--- traceEmbeddedFonts ---");
			
			var embeddedFonts:Array = Font.enumerateFonts(false);
			var font:Font;
			var i:int = 0;
			var numLoops:int = embeddedFonts.length;
			for(i; i < numLoops; i++)
			{
				font = embeddedFonts[i];
				trace("\t[" + i + "]\nfontName:" + font.fontName + ",\nstyle: " + font.fontStyle + ",\ntype: " + font.fontType + "\n");
			}
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
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}


		private function removeListeners():void
		{
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
		}


		// + ----------------------------------------
		//		[ EVENT HANDLERS ]
		// + ----------------------------------------

		private function onIOError(_:IOErrorEvent):void
		{
			trace("\n", this, "--- loaderIOErrorHandler ---");
			trace("\t", "fonts SWF URL:", _url);
			trace("\t", "event:", _);
			trace("\t", "event.text:", _.text);
			
			_isLoading = true;
			removeListeners();
			
			var ioErrorData:Object = {};
			ioErrorData.text = _.text;
			ioErrorData.errorID = _.errorID;
			
			var ioError:LoaderEvent = new LoaderEvent(LoaderEvent.LOADER_ERROR);
			ioError.data = ioErrorData;
			
			dispatchEvent(ioError);
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
		 * The URL of the file that is provided to the loader.
		 */
		public function get url():String
		{
			return _url;
		}


	}
}