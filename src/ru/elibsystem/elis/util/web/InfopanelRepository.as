package ru.elibsystem.elis.util.web {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.collections.ArrayCollection;
	import ru.elibsystem.elis.model.InfopanelNews;
	import ru.elibsystem.elis.model.InfopanelVideo;
	import ru.elibsystem.elis.model.InfopanelInfoBlock;
	/**
	 * Infopanel remote request 
	 * @author Arsen I. Borovinskii
	 */
	public class InfopanelRepository {
		
		// $base_url /infopanel/infoblock/random
		
		// $base_url /infopanel/random/public/browser?format=json"
		
		public var videoSuccess:Function;
		
		public var videoError:Function;
		
		public var infoBlockSuccess:Function;
		
		public var infoBlockError:Function;
		
		public var rssSuccess:Function;
		
		/**
		 * callback if rss error. not it not use because auto rss reloading
		 */
		public var rssError:Function;
		
		public var baseUrl:String;
		
		/**
		 * Где находится RSS
		 */ 
		public var rssUrl:String;
		
		/**
		 * Где находится CSS для RSS
		 */ 
		public var cssUrl:String;
		
		private var videoLoader:URLLoader;
		
		private var infoBlockLoader:URLLoader;
		
		private var rssLoader:URLLoader;
		
		public function InfopanelRepository() {
			//baseUrl = "http://k.psu.ru/infopanel";
		}
		
		public function loadVideo():void {
			videoLoader = new URLLoader;
			var request:URLRequest = new URLRequest(baseUrl + "/infopanel/random/public/browser?format=json");
			if (!videoLoader.hasEventListener(Event.COMPLETE))
				videoLoader.addEventListener(Event.COMPLETE, videoLoadComplete, false, 0, false);
			if (!videoLoader.hasEventListener(IOErrorEvent.IO_ERROR))
				videoLoader.addEventListener(IOErrorEvent.IO_ERROR, videoLoadError);
			videoLoader.load(request);			
		}
		
		public function loadInfoBlock():void {
			infoBlockLoader = new URLLoader;
			var request:URLRequest = new URLRequest(baseUrl + "/infopanel/infoblock/random?format=embedHtml");
			if (!infoBlockLoader.hasEventListener(Event.COMPLETE))
				infoBlockLoader.addEventListener(Event.COMPLETE, infoBlockLoadComplete, false, 0, false);
			if (!infoBlockLoader.hasEventListener(IOErrorEvent.IO_ERROR))
				infoBlockLoader.addEventListener(IOErrorEvent.IO_ERROR, infoBlockLoadError);
			infoBlockLoader.load(request);			
		}
		
		public function loadRss():void {
			rssLoader = new URLLoader;
			var request:URLRequest = new URLRequest(rssUrl);
			if (!rssLoader.hasEventListener(Event.COMPLETE))
				rssLoader.addEventListener(Event.COMPLETE, rssLoadComplete, false, 0, false);
			if (!rssLoader.hasEventListener(IOErrorEvent.IO_ERROR))
				rssLoader.addEventListener(IOErrorEvent.IO_ERROR, rssLoadError);
			rssLoader.load(request);			
		}
		
		private function videoLoadComplete(event:Event):void {
			trace("loadVideo " + event.target.data);
			var infopanelVideo:InfopanelVideo = new InfopanelVideo();
			var json:Object;
			try {
				json = JSON.parse(event.target.data);
				infopanelVideo.urlMp4 = json.url_mp4;
				infopanelVideo.urlWebm = json.url;
				if (videoSuccess != null)
					videoSuccess(infopanelVideo);
			} catch (e:Error) {
				trace("can not parse json of infopanelVideo");
				videoLoadError(null);	
			}
		}
		
		private function videoLoadError(event:IOErrorEvent):void {
			videoLoader.close();
			loadVideo();
		}
		
		private function infoBlockLoadComplete(event:Event):void {
			//trace("load infoblock " + event.target.data);			
			var infoBlock:InfopanelInfoBlock = new InfopanelInfoBlock();
			var json:Object;
			try {
				//json = JSON.parse(event.target.data);
				//infoBlock.htmlCode = json.toString();
				infoBlock.htmlCode = event.target.data;
				if (infoBlockSuccess != null)
					infoBlockSuccess(infoBlock);
			} catch (e:Error) {
				trace("can not parse json of infopanelInfoBlock" + e);
				infoBlockLoadError(null);	
			}
		}
		
		private function infoBlockLoadError(event:IOErrorEvent):void {
			infoBlockLoader.close();
			loadInfoBlock();
		}
		
		private function rssLoadComplete(event:Event):void {
			//trace("loadVideo " + event.target.data);
			trace("rss load complete");
			
			var newsItems:ArrayCollection = new ArrayCollection();	
			try {
				var resultXML:XML = XML(event.target.data);
							
				if (resultXML.namespace("") != undefined) 
				{ 
					default xml namespace = resultXML.namespace(""); 
				}
				
				
				for each(var item:XML in resultXML..item) {
					var news:InfopanelNews = new InfopanelNews();
					news.title = item.title;
					news.body = item.description;
					news.link = item.link;
					newsItems.addItem(news);
					//trace(news.body);
				}			
						
				if (rssSuccess != null)
					rssSuccess(newsItems);
			} catch (e:Error) {
				trace("InfopanelRepository can not parse News of InfopanelNews");
				rssLoadError();	
			}
		}
		
		private function rssLoadError(event:IOErrorEvent=null):void {
			rssLoader.close();
			loadRss();
		}
		
		private function removeEvents():void {
			videoLoader.removeEventListener(Event.COMPLETE, videoLoadComplete);
			videoLoader.removeEventListener(IOErrorEvent.IO_ERROR, videoLoadError);
			infoBlockLoader.removeEventListener(Event.COMPLETE, infoBlockLoadComplete);
			infoBlockLoader.removeEventListener(IOErrorEvent.IO_ERROR, infoBlockLoadError);
			rssLoader.removeEventListener(Event.COMPLETE, rssLoadComplete);
			rssLoader.removeEventListener(IOErrorEvent.IO_ERROR, rssLoadError);
		}
		
	}

}