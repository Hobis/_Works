package works
{
	import flash.display.Sprite;
	import flash.media.SoundChannel;
	import hb.core.ICallBack;	
	import flash.events.Event;

	public final class TW_SoundChannel implements ICallBack
	{
		// ::
		public function TW_SoundChannel(startTime:Number, endTime:Number, loopCountEnd:uint)
		{
			_startTime = startTime;
			_endTime = endTime;
			_loopCountEnd = loopCountEnd;
			_loopCount = 0;
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

		// -
		private static const _us:Sprite = new Sprite();

		// -
		private var _sc:SoundChannel = null;
		
		
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
		public function dispose():void
		{
			_startTime = NaN;
			_endTime = NaN;
			_loopCountEnd = 0;
			_loopCount = 0;
			if (_sc != null)
			{
				_sc.removeEventListener(Event.SOUND_COMPLETE, p_playEnd);
				_sc = null;
			}
		}
		
		// ::
		private function p_playEnd(event:Event):void
		{
		}
		
		// ::
		public function stop():void
		{
		}
		
	}
}
