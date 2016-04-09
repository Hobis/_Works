package
{
	import flash.display.Sprite;	
	import flash.events.Event;	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import hb.core.ICallBack;

	public final class TW_SoundChannel implements ICallBack
	{
		// ::
		public function TW_SoundChannel(
							snd:Sound, volume:Number,
							startTime:Number, endTime:Number,
							callBack:Function)
		{
			_snd = snd;
			_soundTransform = new SoundTransform(volume);
			_startTime = startTime;
			_endTime = endTime;
			_callBack = callBack;
		}

		// -
		private static const _us:Sprite = new Sprite();

		// -
		private var _snd:Sound = null;
		private var _soundTransform:SoundTransform = null;
		private var _startTime:Number;
		private var _endTime:Number;
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

		// :: 재생정지하면 객체 폐기
		public function stop():void
		{
			if (_snd == null) return;
			_us.removeEventListener(Event.ENTER_FRAME, p_enterFrame);			
			_snd = null;
			_soundTransform = null;
			_startTime = NaN;
			_endTime = NaN;
			if (_sc != null)
			{
				try
				{
					_sc.stop();
				}
				catch (e:Error) {}
				_sc.removeEventListener(Event.SOUND_COMPLETE, p_playEnd);
				_sc = null;
			}
			
			//trace('객체 폐기됨');
		}
		
		
		// ::
		private function p_playEnd(event:Event):void
		{
			this.stop();
			this.dispatch_callBack({type: TW_Sound.CT_PLAY_END});
		}
		
		// ::
		private function p_enterFrame(event:Event):void
		{
			if (_snd == null) return;
			if (_sc.position >= _endTime)
			{
				p_playEnd(null);
			}			
		}
		
		// ::
		public function play():void
		{
			if (_snd == null) return;
			_sc = _snd.play(_startTime, 0, _soundTransform);
			_sc.addEventListener(Event.SOUND_COMPLETE, p_playEnd);
			if (_endTime > 0)
			{
				_us.addEventListener(Event.ENTER_FRAME, p_enterFrame);
				p_enterFrame(null);
			}			
		}
		
		// ::
		public function is_play():Boolean
		{
			return (_snd != null);
		}
	}
}
