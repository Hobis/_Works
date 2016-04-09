package works
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
		private static const _us:Sprite = new Sprite();

		// -
		private var _ur:URLRequest = null;
		// -
		private var _snd:Sound = null;
		// -
		private var _sc:SoundChannel = null;
		// -
		private var _scs:Array = null;
		

		public static const CT_IO_ERROR:String = IOErrorEvent.IO_ERROR;
		public static const CT_LOADED:String = 'loaded';
		public static const CT_PLAY_END:String = 'playEnd';
		public static const CT_PLAY_END_ALL:String = 'playEndAll';
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
			this.stop();
			try
			{
				_snd.close();
			}
			catch (e:Error) {}
			_snd.removeEventListener(Event.COMPLETE, p_loaded);
			_snd = null;
			_startTime = NaN;
			_endTime = NaN;
			_loopCountEnd = 0;
			_loopCount = 0;
			_ur = null;
		}
		

		

		
		// ::
		private function p_playEnd(event:Event):void
		{
			this.stop();
			this.dispatch_callBack({type: CT_PLAY_END});
		}

		// ::
		public function stop():void
		{
			if (_sc == null) return;
			_us.removeEventListener(Event.ENTER_FRAME, p_enterFrame);
			try
			{
				_sc.stop();
			}
			catch (e:Error) {}
			_sc.removeEventListener(Event.SOUND_COMPLETE, p_playEnd);
			_sc = null;
		}
		
		// ::
		private function p_enterFrame(event:Event):void
		{
			if (_sc.position >= _endTime)
			{
				if (_loopCount >= _loopCountEnd)
				{
					p_playEnd(null);
					this.dispatch_callBack({type: CT_PLAY_END_ALL});
				}
				else
				{
					p_playEnd(null);
					_loopCount += 1;
					p_playCore();
				}
			}
		}
		
		private var _startTime:Number;
		private var _endTime:Number;
		private var _loopCountEnd:uint;
		public function get_loopCountEnd():uint
		{
			return _loopCountEnd;
		}
		private var _loopCount:uint;
		public function get_loopCount():uint
		{
			return _loopCount;
		}
		
		// ::
		private function p_playCore():void
		{
			_sc = _snd.play(_startTime);
			_sc.addEventListener(Event.SOUND_COMPLETE, p_playEnd);
			if (_endTime > 0)
			{
				_us.addEventListener(Event.ENTER_FRAME, p_enterFrame);
				p_enterFrame(null);
			}
		}
		
		// ::
		private function p_play(startTime:Number = 0, endTime:Number = 0, loops:uint = 1):void
		{
			_startTime = startTime;
			if (endTime < _snd.length)
				_endTime = endTime;
			else
				_endTime = _snd.length;
			_loopCountEnd = loops;
			_loopCount = 1;
			p_playCore();
		}
		
		// ::
		public function play(startTime:Number = 0, endTime:Number = 0, loops:uint = 1):void
		{
			this.stop();
			p_play(startTime, endTime, loops);
		}

		// ::
		public function play2(startTime:Number = 0, endTime:Number = 0, loops:uint = 1):void
		{
			p_play(startTime, endTime, loops);
		}


	}
}
