package
{	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hb.utils.URLLoaderUtil;
	import tools.TxtTool;
	

	public final class FlaRoot
	{		
		public function FlaRoot(owner:MovieClip)
		{
			_owner = owner;
			_puw = new PopUpWrap(_owner.popUp_mc, 'pu_');
			
			TxtTool.clear(_owner.mc_2, 'tf_1');
			TxtTool.clear(_owner.mc_1, 'tf_2');
			
			this.xmlLoad('./Data/Default.xml');
		}
		
		private var _owner:MovieClip = null;
		private var _puw:PopUpWrap = null;
		private var _twork:TWork = null;
		

		// ::
		public function xmlLoad(url:String):void
		{
			URLLoaderUtil.createAndLoad(url, p_xmlLoadComplete);
		}

		// ::
		private function p_xmlLoadComplete(event:Event):void
		{
			var t_ul:URLLoader = URLLoader(event.currentTarget);
			this.init(String(URLLoader(event.currentTarget).data));
			//XML.ignoreWhitespace = true;
			//XML.prettyPrinting = true;
			var t_xml:XML = new XML(String(t_ul.data));
			_twork = new TWork(_owner.tworkCont_mc, t_xml);
			//_twork.clear();
			
			TxtTool.set(_owner.mc_2, 'tf_1', 
						t_xml.child('Name').toString() + ' / ' +
						t_xml.child('Title').toString());


			// 
			SimpleButton(_owner.bt_8).addEventListener('click',
				function(e:*):void
				{
					_twork.stopAll();
				}
			);
			
			// 
			SimpleButton(_owner.bt_7).addEventListener('click',
				function(e:*):void
				{
					_puw.open(1);
				}
			);
			
			// 
			SimpleButton(_owner.bt_1).addEventListener('click',
				function(e:*):void
				{
					_puw.open(2);
				}
			);
		}
		
		// ::
		public function init(xmlStr:String):void
		{
			var t_xml:XML = new XML(xmlStr);
			_twork = new TWork(_owner.tworkCont_mc, t_xml);
			_twork.clear();
			_twork = new TWork(_owner.tworkCont_mc, t_xml);
			_twork.clear();
			_twork = new TWork(_owner.tworkCont_mc, t_xml);			

			

			
			_owner.bt_8.addEventListener('click',
				function(e:*):void
				{
					_twork.stopAll();
				}
			);
		}
		
		// ::
		public function dispose():void
		{
		}		
	}	
}
