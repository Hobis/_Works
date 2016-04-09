package tools
{	
	import flash.external.ExternalInterface;

	public final class FrmProxy
	{
		public function FrmProxy()
		{
		}
		
		public static function call(funcName:String, ...args):void
		{
			if (ExternalInterface.available)
				ExternalInterface.call(funcName, args);
		}
		
		public static function addCallback(funcName:String, closure:Function):void
		{
			if (ExternalInterface.available)
				ExternalInterface.addCallback(funcName, closure);
		}
	}	
}
