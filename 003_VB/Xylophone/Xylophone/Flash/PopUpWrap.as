package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import hb.core.IWrap;
	import hb.utils.DisplayObjectContainerUtil;
	
	
	// #
	public class PopUpWrap implements IWrap
	{
		private var _frontName:String = null;
		private var _npm:MovieClip = null;
		
		// :: 검색후 아이템 설정
		private function p_contLoop(cdo:DisplayObject, index:int):void
		{
			var t_pm:MovieClip = cdo as MovieClip;
			if (t_pm != null)
			{
				t_pm.visible = false;
				switch (t_pm.name)
				{
					case 'pu_1':
					{
						SimpleButton(t_pm.bt_1).addEventListener(MouseEvent.CLICK,
							function(event:MouseEvent):void
							{
								close();
							}
						);
						break;
					}
					
					case 'pu_2':
					{
						SimpleButton(t_pm.bt_2).addEventListener(MouseEvent.CLICK,
							function(event:MouseEvent):void
							{
								close();
							}
						);
						
						SimpleButton(t_pm.bt_1).addEventListener(MouseEvent.CLICK,
							function(event:MouseEvent):void
							{
								close();
							}
						);						
						break;
					}
				}
			}
		}
		
		// :: 팝업 닫기
		public function close():void
		{
			if (_npm != null)
			{
				_npm.visible = false;
				_npm = null;
			}
		}

		// :: 팝업 열기
		public function open(pmn:int, pObj:Object = null):void
		{
			this.close();
			var t_pm:MovieClip = _owner[_frontName + pmn];
			if (t_pm != null)
			{
				_npm = t_pm;
				_npm.visible = true;
			}
		}
		
		
		// :: 생정
		public function PopUpWrap(owner:MovieClip, frontName:String)
		{
			_owner = owner;
			_frontName = frontName;
			
			DisplayObjectContainerUtil.contLoop(_owner, _frontName, p_contLoop);
		}		
		
		// :: 객체참조
		private var _owner:MovieClip = null;
		public function get_owner():MovieClip
		{
			return _owner;
		}

		// - 콜백 함수
		private var _callBack:Function = null;
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}
		
		// :: 콜백 호출
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack != null)
			{
				_callBack(eObj);
			}
		}
		
		// :: 객체 파기
		public function clear():void
		{
			if (_owner != null)
			{
				this.close();
				_owner = null;
			}
		}
		


	}	
}
