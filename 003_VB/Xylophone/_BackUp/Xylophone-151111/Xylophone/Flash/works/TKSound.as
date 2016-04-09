package works
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public final class TKSound
	{
		public function TKSound(snd:Sound)
		{
			_snd = snd;
		}

		private var _snd:Sound = null;
		private var _sc:SoundChannel = null;


		public static const CT_PLAYEND:String = 'playend';
		public static const CT_PLAYING:String = 'playing';
		private var _callBack:Function = null;
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack != null)
			{
				_callBack(eObj);
			}
		}
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}

		private static const _us:Sprite = new Sprite();
		private function p_ef(event:Event):void
		{
			if (_sc == null) return;
			_pos = Math.ceil(_sc.position);
			if (_pos >= _et)
			{
				p_sc_complete(null);
			}
			else
			{
				this.dispatch_callBack({type: CT_PLAYING});
			}
		}




		public function clear():void
		{
			if (_snd == null) return;
			this.stop();
			_callBack = null;
			_snd = null;
		}

		public function stop():void
		{
			if (_sc != null)
			{
				_et = NaN;
				_us.removeEventListener(Event.ENTER_FRAME, p_ef);
				_sc.removeEventListener(Event.SOUND_COMPLETE, p_sc_complete);
				try
				{
					_sc.stop();
				}
				catch (e:Error) {}
				_sc = null;
			}
		}

		private var _pos:Number = 0;
		private var _et:Number;		


		public function get_length():Number
		{
			if (_snd == null) return NaN;
			return Math.ceil(_snd.length);
		}

		public function get_pos():Number
		{
			return _pos;
		}
		
		public function set_pos(v:Number):void
		{
			var t_min:Number = 0,
				t_max:Number = this.get_length();
			if (v < 0)
				_pos = 0;
			else
			if (v > t_max)
				_pos = t_max;
			else
				_pos = v;			
		}		
		
		public function get_ratio():Number
		{
			var t_rv:Number = _pos / this.get_length();
			if (isNaN(t_rv)) t_rv = 0;
			return t_rv;
		}
		
		public function get_volume():Number
		{
			if (_sc == null) return NaN;
			var t_st:SoundTransform = _sc.soundTransform;
			return t_st.volume;
		}
		
		public function set_volume(v:Number):void
		{
			if (_sc == null) return;
			var t_st:SoundTransform = _sc.soundTransform;
			t_st.volume = v;
			_sc.soundTransform = t_st;
		}

		private function p_sc_complete(event:Event):void
		{			
			this.stop();
			this.dispatch_callBack({type: CT_PLAYEND});
		}

		public function play(st:Number = NaN, et:Number = NaN, v:Number = 0.6):void
		{
			if (_sc == null)
			{
				if (!isNaN(st))
					_pos = Math.ceil(st);
				_et = Math.ceil(et);
				var t_sl:Number = Math.ceil(_snd.length);
				if (isNaN(_et) || (_et >= t_sl))
					_et = t_sl;				
				_sc = _snd.play(_pos);
				this.set_volume(v);
				_sc.addEventListener(Event.SOUND_COMPLETE, p_sc_complete);
				_us.addEventListener(Event.ENTER_FRAME, p_ef);
				p_ef(null);
			}
		}
		
		public function get_isPlay():Boolean
		{
			if (_sc == null) return false;
			else return true;
		}
	}
}