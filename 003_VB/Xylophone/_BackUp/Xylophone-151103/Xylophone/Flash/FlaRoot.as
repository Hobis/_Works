package
{	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.System;
	import hbworks.uilogics.ButtonLogic;
	import tools.FrmProxy;
	import hb.utils.URLLoaderUtil;
	import tools.TxtTool;
	


	public final class FlaRoot
	{
		public function FlaRoot(owner:MovieClip)
		{
			_owner = owner;
			_owner.mouseChildren = false;
			/*
			SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
				function(event:MouseEvent):void
				{
					System.useCodePage = true;
					
					var t_ul:URLLoader = new URLLoader();
					t_ul.addEventListener(Event.COMPLETE,
						function(event:Event):void
						{
							var t_ul:URLLoader = URLLoader(event.currentTarget);
							trace(String(t_ul.data));
						}
					);
					t_ul.load(new URLRequest('http://player.afreeca.com/'));
				}
			);			*/
			TxtTool.start(_owner, 'tf_');
			TxtTool.clear('1');
			TxtTool.set_visible('1', false);

			_bl1 = new ButtonLogic(owner.bl_1, true);
			_bl1.addEventListener(MouseEvent.CLICK,
				function(event:MouseEvent):void
				{
					FrmProxy.call('Frm_IsAwaysTop', _bl1.selected);
				}
			);
			
			_bl2 = new ButtonLogic(owner.bl_2, true);
			_bl2.addEventListener(MouseEvent.CLICK,
				function(event:MouseEvent):void
				{
				}
			);
			
			MovieClip(_owner.mc_1).d_is = false;
			HB_Proxy.hb_mc_addClickHandler(MovieClip(_owner.mc_1),
				function(event:MouseEvent):void
				{					
					if (event.ctrlKey &&
						event.shiftKey)
					{
						var t_mc:MovieClip = MovieClip(_owner.mc_1);
						if (t_mc.d_is)
						{
							TxtTool.set_visible('1', false);
							t_mc.d_is = false;
						}
						else
						{
							TxtTool.set_visible('1', true);
							t_mc.d_is = true;
						}
					}
				}
			);
			
			
			FrmProxy.addCallback('Fla_Init',
				function(xmlStr:String):void
				{
					_owner.mouseChildren = true;
					_xml = new XML(xmlStr);
					TxtTool.set('1', xmlStr);
					_twork = new TWork(_owner.tworkCont_mc, _xml);
					_twork.set_callBack(p_twork_callBack);
				}
			);
			
/*
	var t_bl:ButtonLogic = new ButtonLogic(this.rect_mc, true);
	t_bl.enabled = false;
	t_bl.addEventListener(MouseEvent.CLICK,
		function(event:Event):void
		{
			t_bl.
		}
	);*/
	/*
			URLLoaderUtil.createAndLoad('./Save1.xml',
				function(event:Event):void
				{
					var t_ul:URLLoader = URLLoader(event.currentTarget);
					trace(t_ul.data);
				}
			);*/
		}
		
		private var _owner:MovieClip = null;
		
		private var _xml:XML = null;
		private var _twork:TWork = null;
		private var _bl1:ButtonLogic = null;
		private var _bl2:ButtonLogic = null;
		
		
		
		// ::
		private function p_twork_callBack(eObj:Object):void
		{
			
		}

	}
	
}
