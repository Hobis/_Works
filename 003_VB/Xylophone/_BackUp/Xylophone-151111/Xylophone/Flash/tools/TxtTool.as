package tools
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;

	public final class TxtTool {

		public function TxtTool() {
			// constructor code
		}

		private static function p_get_tf(cont:DisplayObjectContainer, name:String):TextField
		{
			var t_tf:TextField = cont[name];
			return t_tf;
		}

		public static function get(cont:DisplayObjectContainer, name:String):String
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return null;
			return t_tf.text;
		}

		public static function set(cont:DisplayObjectContainer, name:String, v:String):void
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return;
			t_tf.text = v;
		}

		private static const _NEW_LINE:String = '\n';
		public static function add(cont:DisplayObjectContainer, name:String, v:String, bNewLine:Boolean = true):void
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return;
			if (bNewLine)
				t_tf.appendText(v + _NEW_LINE);
			else
				t_tf.appendText(v);
		}

		public static function newLine(cont:DisplayObjectContainer, name:String):void
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return;
			t_tf.appendText(_NEW_LINE);
		}

		public static function clear(cont:DisplayObjectContainer, name:String):void
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return;
			t_tf.text = '';
		}
		
		public static function get_visible(cont:DisplayObjectContainer, name:String):Boolean
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return false;
			return t_tf.visible;
		}
		
		public static function set_visible(cont:DisplayObjectContainer, name:String, b:Boolean):void
		{
			var t_tf:TextField = p_get_tf(cont, name);
			if (t_tf == null) return;
			t_tf.visible = b;
		}
	}

}
