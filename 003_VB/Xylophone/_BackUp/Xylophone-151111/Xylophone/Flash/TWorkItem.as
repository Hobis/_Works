package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import hb.core.IWrap;
	import hb.utils.DisplayObjectUtil;
	import hb.media.SimpleSound;
	import tools.TxtTool;


	public final class TWorkItem implements IWrap
	{
		public function TWorkItem(owner:MovieClip,
							cont:DisplayObjectContainer, xi:XML)
		{
			_owner = owner;
			_owner.mouseChildren = false;
			_cont = cont;
			_xi = xi;
			_cont.addChild(_owner);
			
			var t_url:String = _xi.child('File').child('Path').toString();
			_tws = new TW_Sound(t_url, null, p_tws_callBack);
			_startTime = Number(_xi.child('File').child('StartTime').toString());
			if (isNaN(_startTime)) _startTime = 0;
			_endTime = Number(_xi.child('File').child('EndTime').toString());
			if (isNaN(_endTime)) _endTime = 0;

			TxtTool.clear(_owner, 'tf_1');
			TxtTool.clear(_owner, 'tf_2');
			TxtTool.set(_owner, 'tf_1', _xi.child('Text').toString());
			TxtTool.set(_owner, 'tf_2', _xi.child('Discription').toString());
			
			_owner.buttonMode = true;
			_owner.addEventListener(MouseEvent.CLICK, p_click);
		}

		private var _owner:MovieClip = null;
		public function get_owner():MovieClip
		{
			return _owner;
		}

		private var _callBack:Function = null;
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}

		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack != null)
			{
				_callBack(eObj);
			}
		}

		public function clear():void
		{
			if (_owner != null)
			{
				_cont.removeChild(_owner);
				_cont = null;
				_xi = null;
				_tws.dispose();
				_owner.buttonMode = false;
				_owner.removeEventListener(MouseEvent.CLICK, p_click);
				_owner = null;
			}
		}

		private var _cont:DisplayObjectContainer = null;
		private var _xi:XML = null;
		private var _tws:TW_Sound = null;
		private var _startTime:Number;
		private var _endTime:Number;

		// ::
		public function set_pos(x:Number, y:Number):void
		{
			_owner.x = x;
			_owner.y = y;
		}
		
		// ::
		private function p_click(event:MouseEvent):void
		{
			// 중복 재생
			if (event.shiftKey)
			{
				this.play();
			}
			
			// 재생 정지
			else
			if (event.ctrlKey)
			{
				this.stop();
			}
			
			// 편집 열기
			else
			if (event.altKey)
			{
				this.stop();
			}
			
			// 한번만 재생
			else
			{
				this.stop();
				this.play();
			}
		}
		
		// ::
		private function p_tws_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
				case TW_Sound.CT_IO_ERROR:
				{
					_owner.mouseEnabled = false;
					break;
				}
				case TW_Sound.CT_LOADED:
				{					
					break;
				}
				case TW_Sound.CT_PLAY_END:
				{
					TxtTool.set(_owner, 'tf_3', _tws.get_twscArrLen().toString());
					break;
				}
			}
		}

		// ::
		public function stop():void
		{
			_tws.stopAll();
			TxtTool.set(_owner, 'tf_3', '0');
		}
		
		// ::
		public function play():void
		{
			var t_volume:Number = Number(_xi.child('Volume').toString());
			if (isNaN(t_volume))
				t_volume = 0.6;
			else
				t_volume = t_volume / 100;
			_tws.play(t_volume, _startTime, _endTime);			
			TxtTool.set(_owner, 'tf_3', _tws.get_twscArrLen().toString());			
		}		
	}

}
