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
	import works.TW_Sound;


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
			_twsp = new TW_Sound(t_url, null, p_twsp_callBack);
			_startTime = Number(_xi.child('File').child('StartTime').toString());
			if (isNaN(_startTime)) _startTime = 0;
			_endTime = Number(_xi.child('File').child('EndTime').toString());
			if (isNaN(_endTime)) _endTime = 0;
//			_loop = Number(_xi.child('File').child('Loop').toString());
//			if (isNaN(_loop)) _loop = 0;

			TxtTool.clear(_owner, 'tf_1');
			TxtTool.clear(_owner, 'tf_2');
//			TxtTool.clear(_owner, 'tf_3');
//			TxtTool.clear(_owner, 'tf_4');
			TxtTool.set(_owner, 'tf_1', _xi.child('Text').toString());
			TxtTool.set(_owner, 'tf_2', _xi.child('Discription').toString());
//			TxtTool.set(_owner, 'tf_3', '0');
//			TxtTool.set(_owner, 'tf_4', _loop.toString());
//			try
//			{
//				var t_shape:Shape = Shape(_owner.getChildAt(0));
//				var t_col:uint = uint('0x' + _xi.child('Color').toString().substr(1));
//				DisplayObjectUtil.setColor(t_shape, t_col);
//			}
//			catch (e:Error) {}
			
			_owner.buttonMode = true;
			_owner.addEventListener(MouseEvent.CLICK, p_click);
			
//			_bt1 = _owner.bt_1;
//			_bt2 = _owner.bt_2;
//			_bt1.addEventListener(MouseEvent.CLICK, p_playClick);
//			_bt2.addEventListener(MouseEvent.CLICK, p_stopClick);
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
				_cont.addChild(_owner);
				_cont = null;
				_xi = null;
				_twsp.dispose();
				_owner.buttonMode = false;
				_owner.removeEventListener(MouseEvent.CLICK, p_click);
				_owner = null;
			}
		}

		private var _cont:DisplayObjectContainer = null;
		private var _xi:XML = null;
		private var _twsp:TW_Sound = null;
		private var _startTime:Number;
		private var _endTime:Number;
		//private var _loop:Number;
		
//		private var _bt1:SimpleButton = null;
//		private var _bt2:SimpleButton = null;

		// ::
		public function set_pos(x:Number, y:Number):void
		{
			_owner.x = x;
			_owner.y = y;
		}
		
		// ::
		private function p_click(event:MouseEvent):void
		{
			_twsp.play2(_startTime, _endTime);
		}
		
		// ::
		private function p_twsp_callBack(eObj:Object):void
		{
			switch (eObj.type)
			{
				case TW_Sound.CT_IO_ERROR:
				{
					break;
				}
				case TW_Sound.CT_LOADED:
				{
					break;
				}
				case TW_Sound.CT_PLAY_END:
				{
					break;
				}
				case TW_Sound.CT_PLAY_END_ALL:
				{
					break;
				}
			}
		}
		
//		// ::
//		private function p_playClick(event:MouseEvent):void
//		{
//			_twsp.play2(_startTime, _endTime);
//		}
//		
//		// ::
//		private function p_stopClick(event:MouseEvent):void
//		{
//			_twsp.stop();
//		}

		// ::
		public function stop():void
		{
			_twsp.stop();
		}
	}

}
