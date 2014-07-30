package
{
	import core.IPopUp;
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import hb.useful.PanelLayer;
	import hbworks.uilogics.CheckList;
	import hbworks.uilogics.events.CheckListEvent;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public class PopUpWrap implements IWrap, IPopUp
	{
		// :: 생성자
		public function PopUpWrap(owner:MovieClip) 
		{
			this._owner = owner;
			this._owner.visible = false;
			
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
		
		// - 임시 파라미터 오브젝트 (Temp Parameter Object)
		private var _tpo:Object = null;
		// ::
		private function p_tpo_getValue(p:String):Object
		{
			var t_rv:Object = null;
			
			if (this._tpo != null)
			{
				var t_v:Object = this._tpo[p];
				if (t_v != null)
				{
					t_rv = t_v;
				}
			}
			
			return t_rv;
		}
		
		// :: 팝업 초기화
		public function reset(pi:MovieClip):void
		{			
			switch (pi.name)
			{
				case 'pi_1':
				{
					this.p_alert_reset();
					
					break;
				}

				case 'pi_2':
				{
					this.p_new_reset();
					
					break;
				}
				
				case 'pi_3':
				{
					this.p_info_reset();
					
					break;
				}
				
				case 'pi_4':
				{
					this.p_confirm_reset();
					
					break;
				}
			}
		}		
		
		// :: 팝업 닫기
		public function close():void
		{
			this._owner.visible = false;
			this._tpo = null;
			this.reset(this._panelLayer.get_nowPanel());
			this._panelLayer.unselect();
		}
		
		// :: 팝업 열기
		public function open(type:String, pObj:Object = null):void
		{
			this._tpo = pObj;
			
			var t_pi:MovieClip = null;
			var t_tf:TextField = null;			
			
			switch (type)
			{
				// 알림 패널
				case '#_1':
				{
					this._panelLayer.select(1);
					this._owner.visible = true;
					
					break;
				}
				
				// 정보입력 패널
				case '#_2':
				{
					this._panelLayer.select(2);
					this._owner.visible = true;
					
					break;
				}
				
				// 프로그램정보 패널
				case '#_3':
				{
					this._panelLayer.select(3);
					this._owner.visible = true;
					
					break;
				}
				
				// 확인 패널
				case '#_4':
				{
					this._panelLayer.select(4);

					var t_o:Object = this.p_tpo_getValue('msg');
					if (t_o != null)
					{
						var t_txt:String = String(t_o);
						
						t_pi = this._panelLayer.get_nowPanel();
						t_tf = t_pi.tf_1;
						t_tf.text = t_txt;
					}
					
					this._owner.visible = true;
					
					break;
				}		
			}
		}
		
		
		// - 패널레이어 객체
		private var _panelLayer:PanelLayer = null;
		
		// :: 한번만 초기화
		private function p_init_once():void
		{
			this._panelLayer = new PanelLayer(this._owner, 'pi_');
						
			this.p_alert_init();
			this.p_new_init();
			this.p_info_init();
			this.p_confirm_init();
		}
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 알림 패널 (pi_1)
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 알림 패널 닫기 핸들러
		private function p_alert_close_click(event:MouseEvent):void
		{
			this.close();
		}
		
		// :: 알림 패널 모든 버튼 클릭 핸들러
		private function p_alert_bts_click(event:MouseEvent):void
		{
			var t_sb:SimpleButton = SimpleButton(event.currentTarget);
			
			switch (t_sb.name)
			{
				// 확인버튼 클릭
				case 'bt_1':
				{
					this.p_alert_close_click(null);
					
					break;
				}
			}
		}		
		
		// :: 알림 패널 초기화
		private function p_alert_reset():void
		{
			var t_pi:MovieClip = this._owner.pi_1;
			var t_tf:TextField = t_pi.tf_1;
			t_tf.text = '';
		}
		
		// :: 알림 패널 한번 초기화
		private function p_alert_init():void
		{
			var t_pi:MovieClip = null;
			var t_bt:SimpleButton = null;
			
			
			// 패널 아이템
			t_pi = this._owner.pi_1;
			
			// 닫기버튼 설정
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_alert_close_click);
			
			// 확인버튼 설정
			t_bt = t_pi.bt_1;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_alert_bts_click);
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 정보입력 패널 (pi_2)
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 정보입력 패널 닫기 핸들러
		private function p_new_close_click(event:MouseEvent):void
		{
			this.close();
		}
		
		// :: 정보입력 패널 레이어타입 변경 핸들러
		private function p_new_layerType_change(event:CheckListEvent):void
		{
			this._layerTypeIndex = this._layerTypeCheckList.selectedIndex;
			//trace('여기가? : ' + this._layerTypeIndex);
		}
		
		// :: 정보입력 패널 모든 버튼 클릭 핸들러
		private function p_new_bts_click(event:MouseEvent):void
		{
			var t_sb:SimpleButton = SimpleButton(event.currentTarget);			
			
			switch (t_sb.name)
			{
				// 확인버튼 클릭
				case 'bt_1':
				{
					var t_layerTypeIndex:int = this._layerTypeIndex;					
					
					var t_pi:MovieClip = this._owner.pi_2;
					var t_tf:TextField = null;			
					
					var t_dObj:Object = {};
					
					// 이름
					t_tf = t_pi.tf_1;
					t_dObj.name = t_tf.text;
					
					// 타이틀
					t_tf = t_pi.tf_2;
					t_dObj.title = t_tf.text;
					
					// 레이어 타입
					switch (t_layerTypeIndex)
					{
						// 32강 선택
						case 0:
						{
							t_dObj.layerType = '32';
							
							break;
						}

						// 16강 선택
						case 1:
						{
							t_dObj.layerType = '16';
							
							break;
						}

						// 08강 선택
						case 2:
						{
							t_dObj.layerType = '8';
							
							break;
						}

						// 04강 선택
						case 3:
						{
							t_dObj.layerType = '4';
							
							break;
						}
					}
					
					this.dispatchCallBack({
						type: 'new_confirm',
						dObj: t_dObj
					});
					
					
					this.p_new_close_click(null);
					
					break;
				}
				
				// 취소버튼 클릭
				case 'bt_2':
				{
					
					
					this.p_new_close_click(null);
					
					break;
				}
			}
		}
		
		// :: 정보입력 패널 리셋
		private function p_new_reset():void
		{
			var t_pi:MovieClip = this._owner.pi_2;
			var t_tf:TextField = null;

			t_tf = t_pi.tf_1;
			t_tf.text = MainProxy.NEW_PROJECT_NAME;
			t_tf = t_pi.tf_2;
			t_tf.text = MainProxy.NEW_TITLE_NAME;

			this._layerTypeCheckList.selectedIndexDispatch = 0;
			this._layerTypeIndex = 0;
		}		
		
		// - 
		private var _layerTypeCheckList:CheckList = null;
		// -
		private var _layerTypeIndex:int;
		
		// :: 정보입력 패널 한번 초기화
		private function p_new_init():void
		{
			var t_pi:MovieClip = null;
			var t_bt:SimpleButton = null;
			var t_tf:TextField = null;
			
			
			// 패널 아이템
			t_pi = this._owner.pi_2;
			
			// 닫기
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_close_click);
			
			
			// 프로젝트 네임 설정
			t_tf = t_pi.tf_1;
			t_tf.text = MainProxy.NEW_PROJECT_NAME;
			t_tf.maxChars = 18;
			
			
			// 타이틀 네임 설정
			t_tf = t_pi.tf_2;
			t_tf.text = MainProxy.NEW_TITLE_NAME;
			t_tf.maxChars = 38;
			
			
			// 토너먼트 타임 체크리스트 객체 설정
			const t_sels:Array =
			[
				t_pi.mc_1,
				t_pi.mc_2,
				t_pi.mc_3,
				t_pi.mc_4
			];
			this._layerTypeCheckList = new CheckList(t_sels);
			this._layerTypeCheckList.addEventListener(CheckListEvent.CHANGE, this.p_new_layerType_change);
			this._layerTypeIndex = 0;
			this._layerTypeCheckList.selectedIndexDispatch = this._layerTypeIndex;
			
			
			// 확인
			t_bt = t_pi.bt_1;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_bts_click);
			
			
			// 취소
			t_bt = t_pi.bt_2;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_bts_click);			
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 프로그램정보 패널 (pi_3)
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 프로그램정보 패널 닫기 핸들러
		private function p_info_close_click(event:MouseEvent):void
		{
			this.close();
		}		
		
		// :: 프로그램정보 패널 모든 버튼 클릭 핸들러
		private function p_info_bts_click(event:MouseEvent):void
		{
			var t_sb:SimpleButton = SimpleButton(event.currentTarget);
			
			switch (t_sb.name)
			{
				// 확인버튼 클릭
				case 'bt_1':
				{
					this.p_info_close_click(null);
					
					break;
				}
			}
		}
		
		// :: 프로그램정보 패널 리셋
		private function p_info_reset():void
		{
		}		
		
		// :: 프로그램정보 패널 한번만 초기화
		private function p_info_init():void
		{
			var t_pi:MovieClip = null;
			var t_bt:SimpleButton = null;
			var t_tf:TextField = null;
			
			
			// 패널 아이템
			t_pi = this._owner.pi_3;
			
			// 닫기버튼
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_info_close_click);
			
			// 프로그램정보 표시
			t_tf = t_pi.tf_1;
			t_tf.text = 'Name: ' + MainProxy.INFO_NAME;
			t_tf = t_pi.tf_2;
			t_tf.text = 'Programmed By: ' + MainProxy.INFO_PROGRAMMED_BY;
			t_tf = t_pi.tf_3;
			t_tf.text = 'Comment: \n' + MainProxy.INFO_COMMENT;
			
			// 확인버튼
			t_bt = t_pi.bt_1;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_info_bts_click);
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 확인 패널 (pi_4)
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 확인 패널 닫기 핸들러
		private function p_confirm_close_click(event:MouseEvent):void
		{
			this.close();
		}	
		
		// :: 확인 패널 모든 버튼 클릭 핸들러
		private function p_confirm_bts_click(event:MouseEvent):void
		{
			var t_sb:SimpleButton = SimpleButton(event.currentTarget);
			var t_tpo:Object = this._tpo;
			
			switch (t_sb.name)
			{
				// 확인버튼 클릭
				case 'bt_1':
				{
					this.p_confirm_close_click(null);

					if (t_tpo != null)
					{
						if (t_tpo.afterFunc != undefined)
						{
							t_tpo.afterFunc();
						}
					}
					
					break;
				}
				
				// 취소버튼 클릭
				case 'bt_2':
				{
					this.p_confirm_close_click(null);
					
					break;
				}
			}
		}		
		
		// :: 확인 패널 리셋
		private function p_confirm_reset():void
		{
		}
		
		// :: 확인 패널 한번만 초기화
		private function p_confirm_init():void
		{
			var t_pi:MovieClip = null;
			var t_bt:SimpleButton = null;
			var t_tf:TextField = null;
			
			
			// 패널 아이템
			t_pi = this._owner.pi_4;

			// 닫기버튼
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_confirm_close_click);

			// 확인 클릭
			t_bt = t_pi.bt_1;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_confirm_bts_click);

			// 취소 클릭
			t_bt = t_pi.bt_2;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_confirm_bts_click);
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
