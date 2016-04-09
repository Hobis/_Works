package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
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

			_tf = _owner.tf_1;
			_tf.text = _xi.child('Text').toString();
			try
			{
				var t_shape:Shape = Shape(_owner.getChildAt(0));
				var t_col:uint = uint(_xi.child('Color').toString().substr(1));
				DisplayObjectUtil.setColor(t_shape, t_col);
			}
			catch (e:Error) {}
			
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
				_cont = null;
				_xi = null;
				_tf = null;
				
				_owner.buttonMode = false;
				_owner.removeEventListener(MouseEvent.CLICK, p_click);
				_owner = null;
			}
		}

		private var _cont:DisplayObjectContainer = null;
		private var _xi:XML = null;
		
		private var _tf:TextField = null;

/*
		// ::
		public function get_text():String
		{
			return null;
		}
		
		// ::
		public function set_text(v:String):void
		{
		}*/

		// ::
		public function set_pos(x:Number, y:Number):void
		{
			_owner.x = x;
			_owner.y = y;
		}


		
		public static const TYPE_SOUND_PLAY:String = 'SoundPlay';
		
		// ::
		private function p_click(event:MouseEvent):void
		{
			var t_type:String = _xi.attribute('Type').toString();
			
			switch (t_type)
			{
				case TYPE_SOUND_PLAY:
				{
					var t_url:String = _xi.child('File').child('Path').toString();
					SimpleSound.play(t_url, .3, 0, );
					break;
				}
			}
		}
		
		
		
		// ::
		private function p_soundPlay():void
		{
			
		}
	}

}
