package 
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenLite;
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import hb.utils.MovieClipUtil;
	import hb.utils.StringUtil;
	import hbworks.uilogics.ButtonLogic;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public class TopUiWrap implements IWrap
	{
		// :: 생성자
		public function TopUiWrap(owner:MovieClip) 
		{
			this._owner = owner;
			
			this.p_init_once();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 초기화 설정 부분
		////////////////////////////////////////////////////////////////////////////////////////////////////
		// -
		private var _owner:MovieClip = null;
		
		// :: 참고한 객체 반환
		public function get_owner():MovieClip
		{
			return this._owner;
		}
		
		
		// -
		private var _onCallBack:Function = null;
		
		// :: 콜백 함수 반환
		public function get_onCallBack():Function
		{
			return this._onCallBack;
		}
		
		// :: 콜백 함수 설정
		public function set_onCallBack(onCallBack:Function):void
		{
			this._onCallBack = onCallBack;
		}
		
		// :: 콜백 함수 호출
		public function dispatchCallBack(eventObj:Object):void
		{
			if (this._onCallBack != null)
			{
				this._onCallBack(eventObj);
			}
		}
		
		
		// :: 객체 비움
		public function clear():void
		{
			this._owner = null;
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		// - 기본 높이값
		private var _defaultHeight:Number;
	
		// - 보이기 여부
		private var _visible:Boolean = false;
		// - 편집모드 여부
		private var _isEditMode:Boolean = false;
		// ::
		public function get_isEditMode():Boolean
		{
			return this._isEditMode;
		}
		
		// - 자동닫기 여부
		private var _isAutoClose:Boolean = false;
		// ::
		public function get_isAutoClose():Boolean
		{
			return this._isAutoClose;
		}
		
		// :: 파일 선택 핸들러
		private function p_check_close():void
		{
			if (this._isAutoClose)
			{				
				this.p_close_click(null);
			}
		}
		
		// :: 닫기 클릭 핸들러
		private function p_close_click(event:MouseEvent):void
		{
			if (this._visible)
			{
				this.p_pin_click(null);
			}
		}		
		
		// :: 편집모드 클릭 핸들러
		private function p_editMode_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = ButtonLogic(event.currentTarget);
			this._isEditMode = t_bl.selected;
			
			this.dispatchCallBack({
				type: 'editModeClick'
			});
		}
		
		// :: AutoClose Click Handler
		private function p_autoClose_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = ButtonLogic(event.currentTarget);
			this._isAutoClose = t_bl.selected;
		}
		
		// :: Pin Click Handler
		private function p_pin_click(event:MouseEvent):void
		{
			if (this._visible)
			{
				TweenLite.to(this._owner, .3,
					{y: -(this._defaultHeight - 11), ease: Quint.easeOut});

				this._visible = false;
			}
			else
			{
				TweenLite.to(this._owner, .3,
					{y: 0, ease: Quint.easeOut});

				this._visible = true;
			}
		}		
		
		// :: 모든 버튼 클릭
		private function p_btns_click(event:MouseEvent):void
		{
			var t_sb:SimpleButton = SimpleButton(event.currentTarget);
			var t_num:int = StringUtil.getLastIndex(t_sb.name);
			
			this.p_check_close();
			
			this.dispatchCallBack({
				type: 'itemClick',
				num: t_num
			});
		}
		
		// :: 한번 초기화
		private function p_init_once():void
		{
			this._defaultHeight = this._owner.height;
			this._visible = false;
			this._isEditMode = false;
			this._isAutoClose = false;
			
			
			var t_tf:TextField = null;
			var t_bt:SimpleButton = null;
			var t_bl:ButtonLogic = null;			
			
			
			// 타이틀 설정
			t_tf = this._owner.tf_1;
			t_tf.text = MainProxy.INFO_NAME;
			
			// 닫기버튼
			t_bt = this._owner.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_close_click);
			
			// 편집모드 버튼로직
			t_bl = new ButtonLogic(this._owner.mc_1, true);
			t_bl.addEventListener(MouseEvent.CLICK, this.p_editMode_click);
			//t_bl.selectedDispatch = true;
			
			// 자동닫기 버튼로직
			t_bl = new ButtonLogic(this._owner.mc_2, true);
			t_bl.addEventListener(MouseEvent.CLICK, this.p_autoClose_click);
			t_bl.selectedDispatch = true;
			
			
			// 하단에 핀버튼 (슬라이드 다운/업 해주는 버튼)
			t_bt = this._owner.pin_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_pin_click);
			// 10프래임후 슬라이드 다운
			MovieClipUtil.delayExcute(this._owner, this.p_pin_click, [null], 10);
			
			
			// 새로시작
			t_bt = this._owner.bt_1;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 불러오기
			t_bt = this._owner.bt_2;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 저장하기
			t_bt = this._owner.bt_3;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 스크린샷
			t_bt = this._owner.bt_4;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);	
			
			// 뒤섞기
			t_bt = this._owner.bt_5;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 초기화
			t_bt = this._owner.bt_6;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 정보
			t_bt = this._owner.bt_7;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
			
			// 창초기화
			t_bt = this._owner.bt_8;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_btns_click);
		}
	}
}
