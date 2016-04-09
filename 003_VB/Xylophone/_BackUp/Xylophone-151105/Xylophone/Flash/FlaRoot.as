package
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import hb.utils.URLLoaderUtil;
	

	public final class FlaRoot
	{
		public function FlaRoot(owner:MovieClip)
		{
			_owner = owner;
			
			URLLoaderUtil.createAndLoad('./Data/Default.xml', p_init);
			
			_owner.bt_1.addEventListener('click',
				function(e:*):void
				{
					_twork.stopAll();
				}
			);
		}
		
		private var _owner:MovieClip = null;
		private var _twork:TWork = null;
		
		
		// ::
		private function p_init(event:Event):void
		{
			var t_ul:URLLoader = URLLoader(event.currentTarget);
			XML.ignoreWhitespace = true;
			//XML.prettyPrinting = true;
			var t_xml:XML = new XML(String(t_ul.data));			
			_twork = new TWork(_owner.tworkCont_mc, t_xml);
		}
	}	
}
