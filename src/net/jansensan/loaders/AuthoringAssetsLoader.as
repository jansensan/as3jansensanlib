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
	
	
	/**
	 * <p>The <code>AuthoringAssetsLoader</code> class uses <code>flash.display.Loader</code> to specifically handle the loading of SWF files whose library contain items with export classes.</p>
	 * <p>The assets will be available to use in the whole application once the file is loaded, no need to retrieve any data from the <code>AuthoringAssetsLoader</code>.</p>
	 * 
	 * <p><b>Usage:</b></p>
	 * 
	 * <pre>
	 * function loadAssets():void
	 * {
	 * 	var assetsLoader:AuthoringAssetsLoader = new AuthoringAssetsLoader();
	 * 	assetsLoader.addEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	assetsLoader.addEventListener(LoaderEvent.READY, readyHandler);
	 * 	assetsLoader.load("someSWFFile.swf");
	 * }
	 * 
	 * function progressHandler():void
	 * {
	 * 	trace(assetsLoader.loadedRatio);
	 * }
	 * 
	 * function readyHandler():void
	 * {
	 * 	// a good dev always removes event listeners
	 * 	assetsLoader.removeEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	assetsLoader.removeEventListener(LoaderEvent.READY, readyHandler);
	 * 	
	 * 	trace(assetsLoader.loadedRatio);
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
	public class AuthoringAssetsLoader extends EventDispatcher
	{
		private	var	_url			:String;
		private	var	_loader			:Loader;
		private	var	_isLoading		:Boolean = false;
		private	var	_loadedRatio	:Number = 0;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function AuthoringAssetsLoader()
		{
			super();
		}


		/**
		 * Initiates the loading of an SWF file that ideally contains only a library of items with export classes.
		 * 
		 * @param assetsSWFURL The path to the file, in string format. The <code>AuthoringAssetsLoader</code> will handle the conversion to <code>URLRequest</code>.
		 */
		public function load(url:String):void
		{
			_url = url;
			_loader = new Loader();
			addLoaderListeners();
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
			removeLoaderListeners();
			
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
			removeLoaderListeners();
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
			_loader = null;
			dispatchEvent(new LoaderEvent(LoaderEvent.LOADER_KILLED));
		}


		// + ----------------------------------------
		//		[ PRIVATE/PROTECTED METHODS ]
		// + ----------------------------------------

		private function addLoaderListeners():void
		{
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}


		private function removeLoaderListeners():void
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
			trace("\t", "assets SWF URL:", _url);
			trace("\t", "event:", _);
			trace("\t", "event text:", _.text);
			
			_isLoading = false;
			removeLoaderListeners();
			
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
			removeLoaderListeners();
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