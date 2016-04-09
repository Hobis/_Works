package
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;	
	import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.events.IOErrorEvent;
	import hb.core.ICallBack;	
	

	public final class TW_Sound implements ICallBack
	{
		// ::
		public function TW_Sound(url:String, context:SoundLoaderContext, callBack:Function)
		{
			_ur = new URLRequest(url);
			_snd = new Sound();
			_snd.addEventListener(IOErrorEvent.IO_ERROR, p_ioError);
			_snd.addEventListener(Event.COMPLETE, p_loaded);
			_snd.load(_ur, context);			
			_callBack = callBack;
		}

		// -
		private var _ur:URLRequest = null;
		// -
		private var _snd:Sound = null;
		// -
		private var _sc:SoundChannel = null;
		// -
		private var _twscArr:Array = null;
		public function get_twscArrLen():uint
		{
			if (_twscArr == null) return 0;
			return _twscArr.length;
		}
		

		public static const CT_IO_ERROR:String = IOErrorEvent.IO_ERROR;
		public static const CT_LOADED:String = 'loaded';
		public static const CT_PLAY_END:String = 'playEnd';
		// -		
		private var _callBack:Function = null;
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack != null)
			{
				_callBack(eObj);
			}
		}

		// ::
		private function p_ioError(event:IOErrorEvent):void
		{
			this.dispose();
			this.dispatch_callBack({type: CT_IO_ERROR});
		}

		// ::
		private function p_loaded(event:Event):void
		{
			this.dispatch_callBack({type: CT_LOADED});
		}

 		// ::
		public function dispose():void
		{
			if (_ur == null) return;
			p_stopAll(false);
			try
			{
				_snd.close();
			}
			catch (e:Error) {}
			_snd.removeEventListener(Event.COMPLETE, p_loaded);
			_snd = null;
			_ur = null;
		}
		

		// ::
		public function stopAll():void
		{
			p_stopAll(true);
		}
		
		// ::
		private function p_stopAll(b:Boolean):void
		{
			if (_twscArr == null) return;			
			var t_twsc:TW_SoundChannel = null;
			t_twsc = _twscArr[_twscArr.length - 1];
			if (!b && t_twsc.is_play())
			{				
			}
			else
			{
				for each (t_twsc in _twscArr)
				{
					t_twsc.stop();
				}
				_twscArr = null;
			}
		}
		
		// ::
		private function p_twsc_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
				case CT_PLAY_END:
				{
					p_stopAll(false);
					this.dispatch_callBack({type: CT_PLAY_END});
					break;
				}
			}
		}
		
		// ::
		public function play(volume:Number,
							 startTime:Number = 0, endTime:Number = 0):void
		{
			if (_twscArr == null)
				_twscArr = [];
			if (_twscArr.length < 10)
			{				
				if (endTime >= _snd.length)
					endTime = _snd.length;			
				var t_twsc:TW_SoundChannel =
					new TW_SoundChannel(_snd, volume, startTime, endTime, p_twsc_callBack);
				t_twsc.play();
				_twscArr.push(t_twsc);
			}
		}


	}
}
