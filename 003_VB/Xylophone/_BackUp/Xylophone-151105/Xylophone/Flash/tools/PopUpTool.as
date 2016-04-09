package tools
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Hobis
	 */
	public final class PopUpTool 
	{		
		public function PopUpTool() 
		{
			
		}
		
		public static function start(cont:MovieClip):void
		{
			_cont = cont;
		}
		private static var _cont:MovieClip = null;
		public static function get_cont():MovieClip
		{
			return _cont;
		}

		public static function stop():void
		{
			close();
			_cont = null;
		}
		
		public static function close():void
		{
			_cont.gotoAndStop('#_0');
		}
		
		public static function open(fl:String):void
		{
			_cont.gotoAndStop(fl);
		}
	}

}