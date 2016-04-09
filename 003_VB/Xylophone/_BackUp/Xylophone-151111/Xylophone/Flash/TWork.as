package
{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.System;
	import hb.core.IWrap;
	import tools.TxtTool;	


	public final class TWork implements IWrap
	{
		public function TWork(owner:MovieClip, xml:XML)
		{
			_owner = owner;
			_xml = xml;

			p_initOnce(_owner);
			p_itemsInit();		
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
				p_itemsClear();
				System.disposeXML(_xml);
				_xml = null;
				_callBack = null;
				_owner = null;
			}
		}

		// -
		private var _xml:XML = null;

		private static var _itemClass:Class = null;
		private static var _cont:DisplayObjectContainer = null;
		private static var _mask:Shape = null;
		// :: 한번만 초기화
		private static function p_initOnce(owner:MovieClip):void
		{
			if (_itemClass == null)
			{
				var t_mc:MovieClip = owner.tworkProto_mc;
				owner.removeChild(t_mc);
				_itemClass = t_mc.constructor;
				_cont = new Sprite();
				owner.addChild(_cont);
				_mask = new Shape();
				_mask.graphics.beginFill(0xff000, 1);
				_mask.graphics.drawRect(0, 0, 368, 368);
				_mask.graphics.endFill();
				owner.addChild(_mask);
				_cont.mask = _mask;
			}
		}


		// ::
		private function p_itemsClear():void
		{
			if (_twiArr == null) return;
			for each (var t_twi:TWorkItem in _twiArr)
			{
				t_twi.clear();
			}
			_twiArr = null;
		}
		private var _twiArr:Array = null;

		// ::
		private function p_itemsInit():void
		{
			p_itemsClear();
			var t_xis:XMLList = _xml.child('TWorks').children();
			var t_la:uint = t_xis.length();
			if (t_la > 10) t_la = 9;
			var i:uint = 0;
			for (; i < t_la; i++)
			{
				var t_xi:XML = t_xis[i];
				var t_twi:TWorkItem =
					new TWorkItem(
						MovieClip(new _itemClass()), _cont, t_xi);
				t_twi.set_pos(
					(120 + 4) * (i % 3),
					(120 + 4) * Math.floor(i / 3));
					
				if (_twiArr == null)
					_twiArr = [];
				_twiArr.push(t_twi);
			}
		}
		
		
		// ::
		public function stopAll():void
		{
			if (_twiArr == null) return;
			for each (var t_twi:TWorkItem in _twiArr)
			{
				t_twi.stop();
			}			
		}		
	}

}
