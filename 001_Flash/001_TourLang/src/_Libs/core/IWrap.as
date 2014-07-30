package core    
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public interface IWrap 
	{
		// :: 참고한 객체 반환
		function get_owner():MovieClip;

		// :: 콜백 함수 반환
		function get_onCallBack():Function;
		
		// :: 콜백 함수 설정
		function set_onCallBack(f:Function):void;
		
		// :: 콜백 함수 호출
		function dispatchCallBack(eventObj:Object):void;
		
		// :: 객체 비움
		function clear():void;
	}
}
