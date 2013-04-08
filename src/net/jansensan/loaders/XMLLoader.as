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
	import flash.system.System;


	/**
	 * <p>The <code>XMLLoader</code> class uses <code>flash.net.URLLoader</code> to specifically handle the loading of XML files.</p>
	 * 
	 * <p><b>Usage:</b></p>
	 * 
	 * <pre>
	 * var xmlLoader:XMLLoader;
	 * 
	 * function loadFonts():void
	 * {
	 * 	xmlLoader = new XMLLoader();
	 * 	xmlLoader.addEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	xmlLoader.addEventListener(LoaderEvent.READY, readyHandler);
	 * 	xmlLoader.loadCSS("someXMLFile.xml");
	 * }
	 * 
	 * function progressHandler():void
	 * {
	 * 	trace(xmlLoader.loadedRatio);
	 * }
	 * 
	 * function readyHandler():void
	 * {
	 * 	// a good dev always removes event listeners
	 * 	xmlLoader.removeEventListener(LoaderEvent.PROGRESS, progressHandler);
	 * 	xmlLoader.removeEventListener(LoaderEvent.READY, readyHandler);
	 * 	
	 * 	trace(xmlLoader.XMLData);
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
	public class XMLLoader extends EventDispatcher
	{
		private	var	_loader			:URLLoader;
		private	var	_isLoading		:Boolean = false;
		private	var	_loadedRatio	:Number = 0;
		private	var	_url			:String;
		private	var	_xml			:XML;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public function XMLLoader()
		{
			super();
		}


		/**
		 * Initiates the loading of an XML file.
		 * 
		 * @param url The path to the file, in <code>String</code> format. The <code>XMLLoader</code> will handle the conversion to <code>URLRequest</code>.
		 */
		public function load(url:String):void
		{
			_url = url;
			if(!_loader)
			{
				_loader = new URLLoader();
			}
			
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


		public function disposeXML():void
		{
			if	(	_xml 
					&& _xml is XML
				)
			{
				System.disposeXML(_xml);
			}
			_xml = null;
		}


		/**
		 * Kills the loader, removing its internal event handlers and instances.
		 */
		public function kill():void
		{
			removeListeners();
			disposeXML();
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
			if(!_loader.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			}
			if(!_loader.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			{
				_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
			if(!_loader.hasEventListener(ProgressEvent.PROGRESS))
			{
				_loader.addEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			}
			if(!_loader.hasEventListener(Event.COMPLETE))
			{
				_loader.addEventListener(Event.COMPLETE, onLoaded);
			}
		}


		private function removeListeners():void
		{
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onLoadHasProgressed);
			_loader.removeEventListener(Event.COMPLETE, onLoaded);
		}


		// + ----------------------------------------
		//		[ EVENT HANDLERS ]
		// + ----------------------------------------

		private function onIOError(_:IOErrorEvent):void
		{
			trace("\n", this, "--- onIOError ---");
			trace("\t", "url:", _url);
			trace("\t", "event:", _);
			trace("\t", "event text:", _.text);
			
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
			trace("\n", this, "--- onSecurityError ---");
			trace("\t", "url:", _url);
			trace("\t", "event:", _);
			trace("\t", "event text:", _.text);
			
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
			_isLoading = false;
			removeListeners();
			_xml = XML(_loader.data);
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


		/**
		 * The XML data obtained from the loaded file.
		 * <p>This is left available for backwards compatibility only. It will eventually be removed. Use the <code>XMLLoader.xml</code> property instead</p>
		 * 
		 * @deprecated
		 */
		public function get XMLData():XML
		{
			trace("Warning: the XMLLoader.XMLData property is deprecated. It is left available for backwards compatibility only. It will eventually be removed. Use the XMLLoader.xml property instead.");
			return _xml;
		}


		/**
		 * The XML data obtained from the loaded file.
		 */
		public function get xml():XML
		{
			return _xml;
		}


	}
}