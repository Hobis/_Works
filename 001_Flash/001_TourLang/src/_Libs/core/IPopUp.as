package core   
{	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public interface IPopUp 
	{		
		// :: 팝업 초기화
		function reset(pi:MovieClip):void		
		
		// :: 팝업 닫기
		function close():void;
		
		// :: 팝업 열기
		function open(type:String, pObj:Object = null):void
	}	
}
