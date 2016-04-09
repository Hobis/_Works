package works
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;	
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import hb.utils.DebugUtil;
	import hb.utils.StringUtil;
	import hbworks.uilogics.SliderLogicFrame;	
	import tools.TxtTool;
	import flash.display.MovieClip;
	

	public final class TKSoundPlayer
	{
		//////////////////////////////////////////////////////////////////////////////////////////
		//	# Ui영역 초기화
		//////////////////////////////////////////////////////////////////////////////////////////
		public function TKSoundPlayer(cont:DisplayObjectContainer)
		{
			_cont = cont;
			_cont.mouseChildren = false;
			_vslf = new SliderLogicFrame(_cont['vslider_1'], null, SliderLogicFrame.TYPE_VERTICAL);
			_vslf.onCallBack = p_vslf_callBack;
			_vslf.get_targetCont().visible = false;
			_vslf.set_ratio(0);
			_slf1 = new SliderLogicFrame(_cont['slider_1'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf1.onCallBack = p_slf1_callBack;
			_slf2 = new SliderLogicFrame(_cont['slider_2'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf2.get_targetCont().mouseEnabled = false;
			_slf3 = new SliderLogicFrame(_cont['slider_3'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf3.get_targetCont().mouseEnabled = false;
			//_slf3.set_ratio(1);
			_btnPlay = _cont['pbt_1'];
			_btnPause = _cont['pbt_2'];
			_btnStop = _cont['pbt_3'];
			_btnVolume = _cont['pbt_4'];
			_btnMarkStartPos = _cont['pbt_8'];
			_btnMarkEndPos = _cont['pbt_7'];
			_btnLeftPos = _cont['pbt_6'];
			_btnRightPos = _cont['pbt_5'];			
			_btnPlay.addEventListener(MouseEvent.CLICK, p_btnPlay_click);
			_btnPause.addEventListener(MouseEvent.CLICK, p_btnPause_click);
			_btnStop.addEventListener(MouseEvent.CLICK, p_btnStop_click);
			_btnVolume.addEventListener(MouseEvent.MOUSE_DOWN, p_btnVolume_mdu);
			_btnMarkStartPos.addEventListener(MouseEvent.CLICK, p_btnMarkStartPos_click);
			_btnMarkEndPos.addEventListener(MouseEvent.CLICK, p_btnMarkEndPos_click);
			_btnLeftPos.addEventListener(MouseEvent.CLICK, p_btnLeftPos_click);
			_btnRightPos.addEventListener(MouseEvent.CLICK, p_btnRightPos_click);			
			_cont.stage.addEventListener(KeyboardEvent.KEY_DOWN, p_key_down);
			p_txt_update();
			
			_sliderThumb = _slf1.get_targetCont().t1_mc;
			_sliderThumb.gotoAndStop(1);
		}
	
		private var _cont:DisplayObjectContainer = null;
		private var _vslf:SliderLogicFrame = null;
		private var _slf1:SliderLogicFrame = null;
		private var _slf2:SliderLogicFrame = null;
		private var _slf3:SliderLogicFrame = null;
		private var _btnPlay:SimpleButton = null;
		private var _btnPause:SimpleButton = null;
		private var _btnStop:SimpleButton = null;
		private var _btnVolume:SimpleButton = null;
		private var _btnMarkStartPos:SimpleButton = null;
		private var _btnMarkEndPos:SimpleButton = null;
		private var _btnLeftPos:SimpleButton = null;
		private var _btnRightPos:SimpleButton = null;
		private var _sliderThumb:MovieClip = null;
		
		private var _sp:Number;
		private var _ep:Number;
		
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
		
		// ::
		public function dispose():void
		{
			if (_cont == null) return;
			this.close();
			_vslf.clear();
			_vslf = null;
			_slf1.clear();
			_slf1 = null;
			_slf2.clear();
			_slf2 = null;
			_slf3.clear();
			_slf3 = null;
			_btnPlay.removeEventListener(MouseEvent.CLICK, p_btnPlay_click);
			_btnPause.removeEventListener(MouseEvent.CLICK, p_btnPause_click);
			_btnStop.removeEventListener(MouseEvent.CLICK, p_btnStop_click);
			_btnVolume.removeEventListener(MouseEvent.MOUSE_DOWN, p_btnVolume_mdu);
			_btnMarkStartPos.removeEventListener(MouseEvent.CLICK, p_btnMarkStartPos_click);
			_btnMarkEndPos.removeEventListener(MouseEvent.CLICK, p_btnMarkEndPos_click);
			_btnLeftPos.removeEventListener(MouseEvent.CLICK, p_btnLeftPos_click);
			_btnRightPos.removeEventListener(MouseEvent.CLICK, p_btnRightPos_click);
			_btnPlay = null;
			_btnPause = null;
			_btnStop = null;
			_btnVolume = null;
			_btnMarkStartPos = null;
			_btnMarkEndPos = null;
			_btnLeftPos = null;
			_btnRightPos = null;
			_sliderThumb.gotoAndStop(1);
			_sliderThumb = null;
			_callBack = null;
			_cont.stage.removeEventListener(KeyboardEvent.KEY_DOWN, p_key_down);
			_cont = null;
		}
		
		//
		//
		//
		//
		private function p_txt_update(np:Number = NaN):void
		{
			if (isNaN(np))
			{
				TxtTool.clear(_cont['mc_1'], 'tf_1');
			}
			else
			{
				var t_v:String = np + ' / ' +
					_tks.get_length().toString();
				TxtTool.set(_cont['mc_1'], 'tf_1', t_v);
			}
		}
		
		
		private function p_vslf_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
			case SliderLogicFrame.EVENT_TYPE_MOUSE_UP:
				break;
				
			case SliderLogicFrame.EVENT_TYPE_MOUSE_DOWN:
				break;
				
			case SliderLogicFrame.EVENT_TYPE_UPDATE:
				_tks.set_volume(_vslf.get_ratio());
				break;
			}
		}
		
		private var _tempIsPlay:Boolean = false;
		private function p_slf1_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
			case SliderLogicFrame.EVENT_TYPE_MOUSE_UP:
				var t_sr:Number = _slf1.get_ratio();
				if (t_sr < 1)
				{
					_tks.set_pos(Math.ceil(_tks.get_length() * t_sr));
					p_txt_update(_tks.get_pos());
					if (_tempIsPlay)
					{
						p_btnPlay_click(null);
						_tempIsPlay = false;
					}
				}
				else
				{
					p_tks_callBack({type: TKSound.CT_PLAYEND});
					_tempIsPlay = false;
				}
				break;
				
			case SliderLogicFrame.EVENT_TYPE_MOUSE_DOWN:
				if (_tks.get_isPlay())
				{
					p_btnPause_click(null);
					_tempIsPlay = true;
				}
				break;
				
			case SliderLogicFrame.EVENT_TYPE_UPDATE:
				break;
			}
		}
		
		// ::
		private function p_btnPlay_click(event:MouseEvent):void
		{
			_sliderThumb.gotoAndStop(2);
			_tks.play(NaN, NaN, _vslf.get_ratio());			
		}
		
		// ::
		private function p_btnPause_click(event:MouseEvent):void
		{
			_sliderThumb.gotoAndStop(1);
			_tks.stop();			
		}
		
		// ::
		private function p_btnStop_click(event:MouseEvent):void
		{
			p_btnPause_click(null);
			_tempIsPlay = false;
			_tks.set_pos(0);
			_slf1.set_ratio(0);
			p_txt_update(0);
		}
		
		// ::
		private function p_btnVolume_mdu(event:MouseEvent):void
		{
			switch (event.type)
			{
			case MouseEvent.MOUSE_DOWN:
				_cont.stage.addEventListener(MouseEvent.MOUSE_UP, p_btnVolume_mdu);
				var t_vsc:MovieClip = _vslf.get_targetCont();
				//t_vsc.y = _btnVolume.y + (t_vsc.height * _vslf.get_ratio());
				//t_vsc.y = (_btnVolume.y + (_btnVolume.height / 2)) + (t_vsc.height * _vslf.get_ratio());
				t_vsc.y = _cont.mouseY + (t_vsc.height * _vslf.get_ratio());
				t_vsc.visible = true;
				t_vsc.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
				break;
				
			case MouseEvent.MOUSE_UP:
				_cont.stage.removeEventListener(MouseEvent.MOUSE_UP, p_btnVolume_mdu);
				_vslf.get_targetCont().visible = false;
				break;
			}
		}
		
		// ::
		private function p_btnMarkStartPos_click(event:MouseEvent):void
		{
			_sp = _tks.get_pos();
			_slf2.set_ratio(_tks.get_ratio());
			if (_ep < _sp)
				p_btnMarkEndPos_click(null);
		}
		
		// ::
		private function p_btnMarkEndPos_click(event:MouseEvent):void
		{
			_ep = _tks.get_pos();
			_slf3.set_ratio(_tks.get_ratio());
			if (_sp > _ep)
				p_btnMarkStartPos_click(null);			
		}
		
		// ::
		private function p_btnLeftPos_click(event:MouseEvent):void
		{
			if (event.ctrlKey)
				p_move_pos(-100);
			else
			if (event.shiftKey)
				p_move_pos(-10000);
			else
				p_move_pos(-1000);
		}
		
		// ::
		private function p_btnRightPos_click(event:MouseEvent):void
		{
			if (event.ctrlKey)
				p_move_pos(+100);
			else
			if (event.shiftKey)
				p_move_pos(+10000);
			else
				p_move_pos(+1000);
		}
		
		// ::
		private function p_key_down(event:KeyboardEvent):void
		{
			var t_me:MouseEvent = null;
			t_me = new MouseEvent(MouseEvent.CLICK);
			t_me.ctrlKey = event.ctrlKey;
			t_me.shiftKey = event.shiftKey;
			switch (event.keyCode)
			{
			case Keyboard.LEFT:
				p_btnLeftPos_click(t_me);
				break;
				
			case Keyboard.RIGHT:
				p_btnRightPos_click(t_me);
				break;
			}
		}
		
		// ::
		private function p_move_pos(v:Number):void
		{
			if (_tks.get_isPlay())
			{
				p_btnPause_click(null);
				_tempIsPlay = true;
			}
			_tks.set_pos(_tks.get_pos() + v);
			p_tks_callBack({type: TKSound.CT_PLAYING});
			if (_tempIsPlay)
			{
				p_btnPlay_click(null);
				_tempIsPlay = false;
			}
		}
		

		// -
		private var _tks:TKSound = null;
		// ::
		private function p_tks_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
			case TKSound.CT_PLAYING:
				_slf1.set_ratio(_tks.get_ratio());
				p_txt_update(_tks.get_pos());
				break;
			case TKSound.CT_PLAYEND:
				p_btnPause_click(null);
				p_txt_update(_tks.get_length());
				break;
			}
		}		
		
		// ::
		public function close():void
		{
			if (_tks == null) return;
			_cont.mouseChildren = false;
			p_btnStop_click(null);
			_vslf.set_ratio(0);
			//_slf1.set_ratio(0);
			_slf2.set_ratio(0);
			_slf3.set_ratio(0);
			p_txt_update();
			_tks.clear();
			_tks = null;
		}
		
		// ::
		private function p_set_sp(sp:Number):void
		{
			
		}
		
		// ::
		private function p_set_ep(ep:Number):void
		{
			
		}
		
		// ::
		public function load(snd:Sound, vol:Number, sp:Number = NaN, ep:Number = NaN):void
		{
			if (!(_tks == null)) return;
			_tks = new TKSound(snd);
			_tks.set_callBack(p_tks_callBack);
			_vslf.set_ratio(vol);
			
			if (isNaN(sp)) _sp = 0;
			else _sp = sp;
			if (isNaN(ep)) _ep = _tks.get_length();
			else _ep = ep;
			_slf2.set_ratio(_sp / _tks.get_length());
			_slf3.set_ratio(_ep / _tks.get_length());
			trace(_ep);
			
			p_txt_update(_tks.get_pos());
			_cont.mouseChildren = true;			
		}
		
	}
}
