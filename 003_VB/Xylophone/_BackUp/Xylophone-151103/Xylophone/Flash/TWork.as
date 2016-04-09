package
{
	import flash.display.MovieClip;
	import hb.core.IWrap;
	import tools.TxtTool;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	public final class TWork implements IWrap
	{
		public function TWork(owner:MovieClip, xml:XML)
		{
			_owner = owner;
			_xml = xml;

			if (_itemClass == null)
			{
				var t_mc:MovieClip = _owner.tworkProto_mc;
				_owner.removeChild(t_mc);
				_itemClass = t_mc.constructor;
			}

			XML.ignoreWhitespace = true;
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
				_xml = null;
				_owner = null;
			}
		}


		private var _xml:XML = null;
		private static var _itemClass:Class = null;
		private static var _cont:DisplayObjectContainer = null;
		private static var _mask:Shape = null;


		// ::
		private function p_itemsClear():void
		{
		}

		// ::
		private function p_itemsInit():void
		{
			TxtTool.newLine('1');
			TxtTool.newLine('1');
			TxtTool.newLine('1');
			TxtTool.newLine('1');
			TxtTool.add('1', _xml.TWorks.Item);

			_cont = new Sprite();
			_owner.addChild(_cont);
			_mask = new Shape();
			_mask.graphics.beginFill(0xff000, 1);
			_mask.graphics.drawRect(0, 0, 368, 368);
			_mask.graphics.endFill();
			_owner.addChild(_mask);
			_cont.mask = _mask;

			var t_xis:XMLList = _xml.child('TWorks').children();
			var i:uint = 0;
			for each (var t_xi:XML in t_xis)
			{
				//TxtTool.add('1', t_item.toXMLString());

				var t_twi:TWorkItem =
					new TWorkItem(
						MovieClip(new _itemClass()), _cont, t_xi);
				t_twi.set_pos(
					(120 + 4) * (i % 3),
					(120 + 4) * Math.floor(i / 3));

				i++;
			}

		}
	}

}
