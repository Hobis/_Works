package works
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;	
	import hb.utils.StringUtil;
	import hbworks.uilogics.SliderLogicFrame;
	import hb.utils.DebugUtil;
	import tools.TxtTool;
	

	public final class TKSoundPlayerL
	{
		//////////////////////////////////////////////////////////////////////////////////////////
		//	# 초기화 영역
		//////////////////////////////////////////////////////////////////////////////////////////
		public function TKSoundPlayerL(cont:DisplayObjectContainer)
		{
			_cont = cont;
			_cont.mouseChildren = false;
			_slf1 = new SliderLogicFrame(_cont['slider_1'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf1.onCallBack = p_slf1_callBack;
			_slf2 = new SliderLogicFrame(_cont['slider_2'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf2.get_targetCont().mouseEnabled = false;
			_slf3 = new SliderLogicFrame(_cont['slider_3'], null, SliderLogicFrame.TYPE_HORIZONTAL);
			_slf3.get_targetCont().mouseEnabled = false;
			_slf3.set_ratio(1);
			_btnPlay = _cont['pbt_1'];
			_btnPause = _cont['pbt_2'];
			_btnStop = _cont['pbt_3'];
			_btnVolume = _cont['pbt_4'];
			_btnPlay.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnPause.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnStop.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnVolume.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnMarkStartPos = _cont['pbt_8'];
			_btnMarkEndPos = _cont['pbt_7'];
			_btnMarkStartPos.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnMarkEndPos.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnPrevPos = _cont['pbt_5'];
			_btnNextPos = _cont['pbt_6'];
			_btnPrevPos.addEventListener(MouseEvent.CLICK, p_btns_click);
			_btnNextPos.addEventListener(MouseEvent.CLICK, p_btns_click);
			p_txt_update();
		}
		
		private var _cont:DisplayObjectContainer = null;
		private var _slf1:SliderLogicFrame = null;
		private var _slf2:SliderLogicFrame = null;
		private var _slf3:SliderLogicFrame = null;
		private var _btnPlay:SimpleButton = null;
		private var _btnPause:SimpleButton = null;
		private var _btnStop:SimpleButton = null;
		private var _btnVolume:SimpleButton = null;
		private var _btnMarkStartPos:SimpleButton = null;
		private var _btnMarkEndPos:SimpleButton = null;
		private var _btnPrevPos:SimpleButton = null;
		private var _btnNextPos:SimpleButton = null;
		
		public static const CT_IO_ERROR:String = IOErrorEvent.IO_ERROR;
		public static const CT_LOADED:String = 'loaded';
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
		
		public function dispose():void
		{
			if (_cont == null) return;
			this.close();
			_callBack = null;
			_cont = null;
		}
		//////////////////////////////////////////////////////////////////////////////////////////
		private var _tempIsPlay:Boolean = false;
		private function p_slf1_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
			case SliderLogicFrame.EVENT_TYPE_MOUSE_UP:
				_tks.set_pos(Math.ceil(_tks.get_length() * _slf1.get_ratio()));
				p_txt_update(_tks.get_pos());
				if (_tempIsPlay)
				{
					_tks.play();
					_tempIsPlay = false;
				}
				break;
			case SliderLogicFrame.EVENT_TYPE_MOUSE_DOWN:
				if (_tks.get_isPlay())
				{
					_tks.stop();
					_tempIsPlay = true;
				}
				break;
			case SliderLogicFrame.EVENT_TYPE_UPDATE:
				break;		
			}
		}
		
		private function p_btns_click(event:MouseEvent):void
		{
			if (_tks == null) return;
			var t_bt:SimpleButton = SimpleButton(event.currentTarget);
			switch (t_bt.name)
			{
			// 재생
			case 'pbt_1':
				_tks.play();
				break;
				
			// 일시정지
			case 'pbt_2':
				_tks.stop();
				break;
				
			// 완전정지
			case 'pbt_3':
				_tks.stop();
				_tks.set_pos(0);				
				_slf1.set_ratio(0);
				break;
				
			// 볼륨조절
			case 'pbt_4':
				break;
			
			// 좌측으로 포지션 이동
			case 'pbt_6':
				p_move_pos(-1000);
				break;
				
			// 우측으로 포지션 이동 (1초, 10초, 100초)
			case 'pbt_5':
				p_move_pos(+1000);
				break;
			
			// 시작시간 설정
			case 'pbt_8':
//				if (_slf1.get_ratio() < _slf3.get_ratio())
//					_slf2.set_ratio(_slf1.get_ratio());
//				else
//					_slf2.set_ratio(_slf3.get_ratio());
				break;
			
			// 끝남시간 설정
			case 'pbt_7':
//				if (_slf1.get_ratio() > _slf2.get_ratio())
//					_slf3.set_ratio(_slf1.get_ratio());
//				else
//					_slf3.set_ratio(_slf2.get_ratio());
				break;
			}
		}
		
		private function p_move_pos(v:Number):void
		{
			if (_tks.get_isPlay())
			{
				_tks.stop();
				_tempIsPlay = true;
			}
			_tks.set_pos(_tks.get_pos() + v);
			p_tks_callBack({type: TKSound.CT_PLAYING});
			if (_tempIsPlay)
			{
				_tks.play();
				_tempIsPlay = false;
			}
		}
		
		private var _snd:Sound = null;
		private var _tks:TKSound = null;
		
		private function p_snd_ioError(event:IOErrorEvent):void
		{
			this.close();
			this.dispatch_callBack({type: CT_IO_ERROR});
		}
		
		private function p_snd_complete(event:Event):void
		{
			_tks = new TKSound(_snd);
			_tks.set_callBack(p_tks_callBack);
			p_txt_update(0);
			_cont.mouseChildren = true;
			this.dispatch_callBack({type: CT_LOADED});
		}
		
		private function p_tks_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
			case TKSound.CT_PLAYING:
				_slf1.set_ratio(_tks.get_ratio());
				p_txt_update(_tks.get_pos());
				break;
			case TKSound.CT_PLAYEND:
				p_txt_update(_tks.get_length());
				break;
			}
		}
		
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
		
		public function close():void
		{
			if (_snd == null) return;
			if (_tks != null)
			{
				_tks.clear();
				_tks = null;
			}
			_snd.removeEventListener(Event.COMPLETE, p_snd_complete);
			try
			{
				_snd.close();
			}
			catch (e:Error) {}
			_snd = null;
		}
		
		public function load(ureq:URLRequest):void
		{
			_snd = new Sound();
			_snd.addEventListener(IOErrorEvent.IO_ERROR, p_snd_ioError);
			_snd.addEventListener(Event.COMPLETE, p_snd_complete);
			_snd.load(ureq);
		}
		
	}
}
