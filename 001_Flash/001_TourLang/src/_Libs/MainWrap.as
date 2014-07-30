package 
{
	import com.adobe.images.PNGEncoder;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import core.IWrap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	import hb.utils.ArrayUtil;
	import hb.utils.DebugUtil;
	import hb.utils.MovieClipUtil;
	import hb.utils.NumberUtil;
	import hb.utils.StringUtil;
	import hbworks.uilogics.ButtonLogic;
	import hbworks.uilogics.CheckList;
	import hbworks.uilogics.events.CheckListEvent;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public class MainWrap implements IWrap
	{
		// :: 생성자
		public function MainWrap(owner:MovieClip) 
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
		
		// - Default Info
		private var _defaultInfo:Object = null;
		
		
		// - Data Object
		private var _dObj:Object = null;
		// :: Data Object Clear
		private function p_dObj_clear():void
		{
			if (this._dObj != null)
			{
				this._dObj = null;
			}
		}
		
		
		// - 파일
		private var _file:File = null;
		// - 파일스트림
		private var _fileStream:FileStream = null;
		// - 파일 사용 타입
		private var _fileUseType:String = null;
		
		// - 스크린샷용 파일 객체
		private var _ssf:File = null;
		
		
		// :: 파일 선택 핸들러
		private function p_file_select(event:Event):void
		{
			if (this._fileUseType != null)
			{
				switch (this._fileUseType)
				{
					case MainProxy.FILE_USE_TYPE_OPEN:
					{
						this._fileStream.openAsync(this._file, FileMode.READ);

						break;
					}

					case MainProxy.FILE_USE_TYPE_SAVE:
					{
						if (this._file.extension != MainProxy.FILE_EX_NAME)
						{
							var t_parent:File = this._file.parent;
							this._file = t_parent.resolvePath(this._file.name + '.' + MainProxy.FILE_EX_NAME);
						}

						this._fileStream.openAsync(this._file, FileMode.WRITE);
						this._fileStream.writeObject(this._dObj);
						this._fileStream.close();

						break;
					}
				}

				this._fileUseType = null;
			}
		}
		
		// :: 파일스트림 닫기 핸들러
		private function p_fileStream_close(event:Event):void
		{
		}
		
		// :: 파일스트림 완료 핸들러
		private function p_fileStream_complete(event:Event):void
		{
			if (this._file.exists)
			{
				this.p_lm_reset();

				this._dObj = this._fileStream.readObject();
				this._fileStream.close();

				if (this._dObj.checkLayers == undefined)
				{
					this._dObj.isNew = true;
				}
				
				this.p_lm_checkGoto();
			}
		}

		
		// - PopUpWrap
		private var _popUpWrap:PopUpWrap = null;
		// - TopUiWrap
		private var _topUiWrap:TopUiWrap = null;
		// - 
		private var _titleInfo:MovieClip = null;
		// -
		private var _mapLayer:MovieClip = null;
		
		
		// :: PopUpWrap 콜백 함수
		private function p_popUpWrap_onCallBack(eventObj:Object):void
		{			
			switch (eventObj.type)
			{
				case 'new_confirm':
				{
					// 이미 활성화 된거 리셋팅 하고
					this.p_lm_reset();
					
					this._dObj = eventObj.dObj;
					this._dObj.items = [];
					
					for
					(
						var
							t_la:uint = uint(this._dObj.layerType),
							i:uint = 0;
							
						i < t_la; i++
					)
					{
						this._dObj.items.push({name: ''});
					}
					
					this._dObj.isNew = true;
					
					
					DebugUtil.test('this._dObj.name: ' + this._dObj.name);
					DebugUtil.test('this._dObj.title: ' + this._dObj.title);
					DebugUtil.test('this._dObj.layerType: ' + this._dObj.layerType);
					DebugUtil.test('this._dObj.items.length: ' + this._dObj.items.length);
					DebugUtil.test('this._dObj.isNew: ' + this._dObj.isNew);
					
					
					var t_str:String =
						this._file.parent.nativePath + File.separator +
						this._dObj.name + '.' + MainProxy.FILE_EX_NAME;
					this._file = new File(t_str);
					this._file.addEventListener(Event.SELECT, this.p_file_select);
					
					this.p_lm_checkGoto();
					
					break;
				}
			}
		}
		
		// :: TopUiWrap 콜백 함수
		private function p_topUiWrap_onCallBack(eventObj:Object):void
		{
			switch (eventObj.type)
			{
				// 아이템 클릭
				case 'itemClick':
				{
					switch (eventObj.num)
					{
						// 새로시작
						case 1:
						{
							this._popUpWrap.open('#_2');
							
							break;
						}
						
						// 불러오기
						case 2:
						{							
							this._fileUseType = MainProxy.FILE_USE_TYPE_OPEN;
							this._file.browseForOpen('open', [MainProxy.FILE_USE_FILTER]);
							
							break;
						}
						
						// 저장하기
						case 3:
						{
							if (this._dObj != null)
							{
								this._fileUseType = MainProxy.FILE_USE_TYPE_SAVE;
								this._file.browseForSave('Save As');
							}
							
							break;
						}
						
						// 스크린샷
						case 4:
						{
							this.p_lm_shot();
							
							break;
						}
						
						// 뒤섞기
						case 5:
						{
							this.p_lm_shuffling();
							
							break;
						}
						
						// 초기화
						case 6:
						{
							this.p_lm_workReset();
							
							break;
						}
						
						// 정보
						case 7:
						{
							this._popUpWrap.open('#_3');
							
							break;
						}
						
						// 창 초기화
						case 8:
						{
							var t_stage:Stage = this._owner.stage;
							
							t_stage.stageWidth = this._defaultInfo.dw;
							t_stage.stageHeight = this._defaultInfo.dh;
							//trace('this._defaultInfo.dw: ' + this._defaultInfo.dw);
							//trace('this._defaultInfo.dh: ' + this._defaultInfo.dh);
							
							break;
						}
					}
					
					break;
				}
				
				// 편집모드 클릭
				case 'editModeClick':
				{
					this.p_lm_check_editMode();
					
					break;
				}
			}
		}
		
		// :: MapLayer에 타이틀 텍스트 변경시
		private function p_mapLayer_title_change(event:Event):void
		{
			if (this._dObj != null)
			{
				var t_tf:TextField = TextField(event.currentTarget);
				this._dObj.title = t_tf.text;
			}
		}
		
		// :: 한번만 초기화
		private function p_init_once():void
		{
			// 스테이지 초기화
			var t_stage:Stage = this._owner.stage;
			//t_stage.scaleMode = StageScaleMode.NO_SCALE;
			t_stage.scaleMode = StageScaleMode.SHOW_ALL;
			//t_stage.align = StageAlign.TOP_LEFT;
			
			// 네이티브 윈도우 설정
			var t_win:NativeWindow = t_stage.nativeWindow;
			t_win.title = MainProxy.NAME;
			
			//
			this._defaultInfo = {};
			this._defaultInfo.dw = t_stage.stageWidth;
			this._defaultInfo.dh = t_stage.stageHeight;
			//trace('this._defaultInfo.dw: ' + this._defaultInfo.dw);
			//trace('this._defaultInfo.dh: ' + this._defaultInfo.dh);
			
			//
			this._titleInfo = this._owner.titleInfo_mc;
			//
			this._mapLayer = this._owner.mapLayer_mc;
			
			// 팝업 객체 설정
			this._popUpWrap = new PopUpWrap(this._owner.popUp_mc);
			this._popUpWrap.set_onCallBack(this.p_popUpWrap_onCallBack);
			//this._popUpWrap.open('#_4', {msg: 'aaaa'});
			
			// 상단Ui 객체 설정
			this._topUiWrap = new TopUiWrap(this._owner.topUiBar_mc);
			this._topUiWrap.set_onCallBack(this.p_topUiWrap_onCallBack);

			// 파일 객체 설정
			var t_str:String =
				File.applicationDirectory.nativePath +
				File.separator + MainProxy.FILE_DATA_FOLDER +
				File.separator + MainProxy.FILE_DEFAULT_NAME;
			this._file = new File(t_str);
			this._file.addEventListener(Event.SELECT, this.p_file_select);
			this._fileStream = new FileStream();
			this._fileStream.addEventListener(Event.CLOSE, this.p_fileStream_close);
			this._fileStream.addEventListener(Event.COMPLETE, this.p_fileStream_complete);
			
			// TitleInfo객체 설정
			var t_tf:TextField = this._titleInfo.tf_1;
			t_tf.addEventListener(Event.CHANGE, this.p_mapLayer_title_change);
			t_tf.text = '';
			
			// MapLayer객체 설정
			
			// Tweener 설정
			TweenPlugin.activate([TintPlugin]);
			
			DebugUtil.test('메인 초기화 완료');
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # LayerModule
		////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: LayerModule 스크린샷 select
		private function p_lm_shot_select(event:Event):void
		{
			var t_file:File = File(event.currentTarget);

			var t_bd:BitmapData = new BitmapData(800, 700, false, 0xff292929);
			t_bd.draw(this._owner);

			var t_ba:ByteArray = PNGEncoder.encode(t_bd);
			t_bd.dispose();

			var t_fs:FileStream = new FileStream();
			t_fs.open(t_file, FileMode.WRITE);
			t_fs.writeBytes(t_ba, 0, t_ba.bytesAvailable);
			t_fs.close();
			
			t_ba.clear();
			
			this._ssf.removeEventListener(Event.SELECT, this.p_lm_shot_select);
			this._ssf = null;
		}
		
		// :: LayerModule 스크린샷 버튼 클릭
		private function p_lm_shot():void
		{
			if (this._dObj != null)
			{
				if (this._ssf == null)
				{
					this._ssf = new File();
					this._ssf.addEventListener(Event.SELECT, this.p_lm_shot_select);
				}
				//var t_ff:FileFilter = new FileFilter('Save for png', '*.png;');
				this._ssf.browseForSave('Save for PNG format');
			}
		}

		// :: LayerModule 뒤섞기 버튼 클릭 확인 이후 실행
		private function p_lm_shuffling_after():void
		{
			this.p_lm_workReset_after();

			ArrayUtil.shuffle(this._dObj.items);
			var t_la:uint = this._dObj.items.length;
			for (var i:uint = 0; i < t_la; i++)
			{
				var t_nameItem:MovieClip = this._mapLayer['name_' + i];
				var t_tf:TextField = t_nameItem.tf;
				t_tf.text = this._dObj.items[i].name;
			}
		}

		// :: LayerModule 뒤섞기 버튼 클릭
		private function p_lm_shuffling():void
		{
			if (this._dObj != null)
			{
				this._popUpWrap.open('#_4', {
					msg:
						'\n\n\n' +
						'뒤섞기를 진행하면 현재 리그 정보가 초기화 됩니다.\n' +
						'정말로 진행할까요?'

					,
					afterFunc: this.p_lm_shuffling_after
				});
			}
		}
		
		// :: LayerModule 초기화상태로 이후
		private function p_lm_workReset_after():void
		{
			if (this._dObj.groupLayers != null)
			{
				var t_la:uint = this._dObj.groupLayers.length;
				for (var i:uint = 0; i < t_la; i++)
				{
					var t_stepGroups:Array = this._dObj.groupLayers[i];
					var t_lb:uint = t_stepGroups.length;
					for (var j:uint = 0; j < t_lb; j++)
					{
						var t_cl:CheckList = t_stepGroups[j];
						t_cl.selectedIndexDispatch = -1;
					}
				}
			}
		}

		// :: LayerModule 초기화상태로
		private function p_lm_workReset():void
		{
			if (this._dObj != null)
			{
				this._popUpWrap.open('#_4', {
					msg:
						'\n\n\n\n' +
						'정말로 초기화 할까요?'

					,
					afterFunc: this.p_lm_workReset_after
				});
			}
		}
		
		// :: LayerModule 리셋
		private function p_lm_reset():void
		{
			if (this._dObj != null)
			{			
				var t_stepGroups:Array = null;
				var t_cl:CheckList = null;
				var t_bls:Array = null;
				var t_bl:ButtonLogic = null;
				var t_check:MovieClip = null;

				var t_nameItem:MovieClip = null;
				var t_tf:TextField = null;

				var t_la:uint, i:uint;
				var t_lb:uint, j:uint;
				var t_lc:uint, k:uint;


				if (this._dObj.nameItems != undefined)
				{
					t_la = this._dObj.nameItems.length;
					for (i = 0; i < t_la; i++)
					{
						t_nameItem = this._dObj.nameItems[i];
						t_nameItem.d_bg = null;
						t_tf = t_nameItem.tf;
						t_tf.text = '';
						t_tf.removeEventListener(Event.CHANGE, this.p_lm_nameItem_change);
					}

					this._dObj.nameItems = undefined;
				}

				if (this._dObj.groupLayers != undefined)
				{
					t_la = this._dObj.groupLayers.length;
					for (i = 0; i < t_la; i++)
					{
						t_stepGroups = this._dObj.groupLayers[i];

						t_lb = t_stepGroups.length;
						for (j = 0; j < t_lb; j++)
						{
							t_cl = t_stepGroups[j];
							t_cl.removeEventListener(CheckListEvent.CHANGE, this.p_lm_cl_click);
							t_bls = t_cl.items;

							t_lc = t_bls.length;
							for (k = 0; k < t_lc; k++)
							{
								t_bl = t_bls[k];
								t_check = t_bl.target;
								t_check.d_line = undefined;
								t_check.d_stepIndex = undefined;
								t_check.d_checkIndex = undefined;
								t_check.d_itemIndex = undefined;
								t_check.d_topSelectedIndex = undefined;
								t_check.d_nameItem = undefined;
							}

							t_cl.dispose();
						}
					}

					this._dObj.groupLayers = undefined;
				}

				this._mapLayer.gotoAndStop('#_0');
				
				this.p_dObj_clear();
			}
		}		
		
		// :: LayerModule CheckList Winner Open
		private function p_lm_cl_click_openWinner(lastIndex:int):void
		{
			var t_isLast:Boolean = false;

			switch (this._dObj.layerType)
			{
				case '32':
				{
					t_isLast = (lastIndex == 5);

					break;
				}

				case '16':
				{
					t_isLast = (lastIndex == 4);

					break;
				}

				case '8':
				{
					t_isLast = (lastIndex == 3);

					break;
				}

				case '4':
				{
					t_isLast = (lastIndex == 2);

					break;
				}
			}

			// 여기에 완료 처리
			if (t_isLast)
			{
			}
		}
		
		// :: LayerModule 현재 선택된 연결고리를 상위 방향으로 찾기
		private function p_lm_cl_getCheckSelectedTopObj(check:MovieClip):Object
		{
			var t_checkInfoObj:Object = null;

			var t_cl:CheckList = null;
			var t_bl:ButtonLogic = null;
			var t_check:MovieClip = check;

			var t_toStepIndex:uint = this._dObj.groupLayers.length - 1;
			var i:uint, j:uint;

			// i는 연결고리의 stepIndex, j는 연결고리의 itemIndex
			i = t_check.d_stepIndex;
			j = t_check.d_checkIndex;
			for (; i <= t_toStepIndex; i++)
			{
				j = Math.floor(j / 2);

				if (i == t_check.d_stepIndex)
				{
					if (t_checkInfoObj == null)
					{
						t_checkInfoObj = {};
						t_checkInfoObj.items = [];
						t_checkInfoObj.lastStepIndex = -1;
					}

					t_checkInfoObj.items.push(t_check);
					t_checkInfoObj.lastStepIndex = i;
				}
				else
				{
					t_cl = this._dObj.groupLayers[i][j];
					if (t_cl.selectedIndex == t_check.d_topSelectedIndex)
					{
						t_bl = t_cl.selectedItem;
						if (t_bl != null)
						{
							t_check = t_bl.target;
							t_checkInfoObj.items.push(t_check);
							t_checkInfoObj.lastStepIndex = i;
						}
					}
					else
					{
						break;
					}
				}
			}

			return t_checkInfoObj;
		}
		
		// :: LayerModule
		private function p_lm_cl_checkOver(type:String, target:DisplayObject, stepIndex:int):void
		{
			const t_OVER_COLORS:Array =
			[
				{bgc: 0xffffff, tfc: 0x000000},
				{bgc: 0xffff00, tfc: 0x000000},
				{bgc: 0xffcc00, tfc: 0x000000},
				{bgc: 0xff9900, tfc: 0x000000},
				{bgc: 0xff6600, tfc: 0xffffff},
				{bgc: 0xff0000, tfc: 0xffffff}
			];
			const t_TWEEN_SEC:Number = 0.3;

			var t_index:uint;
			if (stepIndex == 0)
			{
				t_index = 0;
			}
			else
			{
				switch (this._dObj.layerType)
				{
					case '32':
					{
						t_index = 0 + stepIndex;
						
						break;
					}

					case '16':
					{
						t_index = 1 + stepIndex;
						
						break;
					}

					case '8':
					{
						t_index = 2 + stepIndex;
						
						break;
					}

					case '4':
					{
						t_index = 3 + stepIndex;
						
						break;
					}
				}
			}

			if (type == 'bg')
			{
				TweenLite.to(target, t_TWEEN_SEC, {tint: t_OVER_COLORS[t_index].bgc});
			}
			else if (type == 'tf')
			{
				TweenLite.to(target, t_TWEEN_SEC, {tint: t_OVER_COLORS[t_index].tfc});
			}
		}
		
		// :: LayerModule
		private function p_lm_cl_checkOverItems(t_checkInfoObj:Object):void
		{
			var t_check:MovieClip = null;
			var t_line:MovieClip = null;
			var t_la:uint, i:uint;

			t_la = t_checkInfoObj.items.length;
			i = 0;
			for (; i < t_la; i++)
			{
				t_check = t_checkInfoObj.items[i];
				if (i == 0)
				{
					if (t_check.d_nameItem != undefined)
					{
						if (t_checkInfoObj.lastStepIndex == 0)
						{
							this.p_lm_cl_checkOver('tf', t_check.d_nameItem.tf, 0);
							this.p_lm_cl_checkOver('bg', t_check.d_nameItem.d_bg, 0);
						}
						else
						{
							this.p_lm_cl_checkOver('tf', t_check.d_nameItem.tf, t_checkInfoObj.lastStepIndex);
							this.p_lm_cl_checkOver('bg', t_check.d_nameItem.d_bg, t_checkInfoObj.lastStepIndex);
						}
					}
				}
				t_line = t_check.d_line;
				this.p_lm_cl_checkOver('bg', t_line, t_checkInfoObj.lastStepIndex);
			}
		}
		
		// :: LayerModule 모듈 현재 선택된 위치에서 StepIndex 0까지 Index 검색
		private function p_lm_cl_getCheckSelectedDown(check:MovieClip):MovieClip
		{
			var t_rv:MovieClip = null;

			var t_cl:CheckList = null;
			var t_bl:ButtonLogic = null;
			var t_check:MovieClip = check;

			var i:uint, j:uint;

			for (i = t_check.d_stepIndex; i > 0; i--)
			{
				j = i - 1;

				t_cl = this._dObj.groupLayers[j][t_check.d_checkIndex];
				t_bl = t_cl.selectedItem;
				if (t_bl != null)
				{
					t_check = t_bl.target;
					t_rv = t_check;
				}
				else
				{
					break;
				}
			}

			return t_rv;
		}
		
		// :: LayerModule CheckList 선택
		private function p_lm_cl_click(event:CheckListEvent):void
		{
			var t_cl:CheckList = CheckList(event.currentTarget);
			var t_bl:ButtonLogic = null;
			var t_check:MovieClip = null;
			//
			var t_checkInfoObj:Object = null;
			var t_downCheck:MovieClip = null;

			// 밑으로 선택된것이 있으면
			if (event.yetIndex > -1)
			{
				t_bl = t_cl.getItemAt(event.yetIndex);
				t_check = t_bl.target;

				t_checkInfoObj = this.p_lm_cl_getCheckSelectedTopObj(t_check);
				t_checkInfoObj.lastStepIndex = 0;
				this.p_lm_cl_checkOverItems(t_checkInfoObj);

				t_downCheck = this.p_lm_cl_getCheckSelectedDown(t_check);
				if (t_downCheck != null)
				{
					if (t_downCheck.d_stepIndex == 0)
					{
						t_checkInfoObj = this.p_lm_cl_getCheckSelectedTopObj(t_downCheck);
						t_checkInfoObj.lastStepIndex += 1;
						this.p_lm_cl_checkOverItems(t_checkInfoObj);
					}
				}
			}

			if (event.selectedIndex > -1)
			{
				t_bl = t_cl.selectedItem;
				t_check = t_bl.target;

				if (t_check.d_stepIndex == 0)
				{
					t_checkInfoObj = this.p_lm_cl_getCheckSelectedTopObj(t_check);
					t_checkInfoObj.lastStepIndex += 1;
					this.p_lm_cl_checkOverItems(t_checkInfoObj);
					this.p_lm_cl_click_openWinner(t_checkInfoObj.lastStepIndex);
				}
				else
				{
					t_downCheck = this.p_lm_cl_getCheckSelectedDown(t_check);
					if (t_downCheck != null)
					{
						if (t_downCheck.d_stepIndex == 0)
						{
							t_checkInfoObj = this.p_lm_cl_getCheckSelectedTopObj(t_downCheck);
							t_checkInfoObj.lastStepIndex += 1;
							this.p_lm_cl_checkOverItems(t_checkInfoObj);
							this.p_lm_cl_click_openWinner(t_checkInfoObj.lastStepIndex);
						}
					}
					else
					{

					}
				}
			}

			if (t_check != null)
			{
				if (t_cl != null)
				{
					if (this._dObj.checkLayers != undefined)
					{
						var t_arr:Array = this._dObj.checkLayers[t_check.d_stepIndex];
						t_arr[t_check.d_itemIndex] = t_cl.selectedIndex;
					}
				}
			}
		}
		
		// :: LayerModule 네임아니템 텍스트필드 채인지 이벤트
		private function p_lm_nameItem_change(event:Event):void
		{
			if (this._dObj != null)
			{
				var t_tf:TextField = TextField(event.currentTarget);
				var t_nameItem:MovieClip = t_tf.parent as MovieClip;
				var t_index:int = StringUtil.getLastIndex2(t_nameItem.name);

				var t_item:Object = this._dObj.items[t_index];
				t_item.name = t_tf.text;
			}
		}
		
		// :: LayerModule 그룹스 셋팅
		private function p_lm_groups_setting(scope:MovieClip, stepIndex:uint, len:uint):void
		{
			if (NumberUtil.getIsOddEven(Number(len)))
			{
				DebugUtil.test('짝수가 아닙니다.');
			}
			else
			{
				var t_stepGroups:Array = [];
				this._dObj.groupLayers.push(t_stepGroups);

				var t_stepChecks:Array = null;
				if (this._dObj.isNew)
				{
					if (this._dObj.checkLayers == undefined)
					{
						this._dObj.checkLayers = [];
					}

					t_stepChecks = [];
					this._dObj.checkLayers.push(t_stepChecks);
				}

				var t_group:Array = null;
				var t_nameItem:MovieClip = null;
				var t_tf:TextField = null;
				var t_check:MovieClip = null;
				var t_cl:CheckList = null;

				var t_div:uint = 2;
				var t_la:uint = len;
				var i:uint, j:uint;
				var t_a:uint;

				for (i = 0; i < t_la; i++)
				{
					t_check = scope['check_' + stepIndex + '_' + i];
					t_check.tabEnabled = false;
					t_check.d_line = scope['line_' + stepIndex + '_' + i];

					t_a = i % 2;
					if (t_a == 0)
					{
						t_group = [];
						t_group.push(t_check);
					}
					else
					{
						t_group.push(t_check);
						t_cl = new CheckList(t_group);
						t_cl.isToggleMode = true;
						t_cl.name = 'cl_' + stepIndex + '_' + (j++);
						t_cl.addEventListener(CheckListEvent.CHANGE, this.p_lm_cl_click);
						t_stepGroups.push(t_cl);

						if (this._dObj.isNew)
						{
							t_stepChecks.push(-1);
						}
					}

					t_check.d_stepIndex = stepIndex;
					t_check.d_checkIndex = i;
					t_check.d_itemIndex = Math.floor(i / 2);
					t_check.d_topSelectedIndex = t_check.d_itemIndex % 2;


					if (stepIndex == 0)
					{
						t_nameItem = scope['name_' + i];
						t_tf = t_nameItem.tf;
						t_tf.text = this._dObj.items[i].name;
						t_tf.tabIndex = i;
						t_tf.addEventListener(Event.CHANGE, this.p_lm_nameItem_change);
						t_nameItem.tabEnabled = false;
						t_nameItem.d_bg = t_nameItem.getChildAt(0) as Shape;
						t_check.d_nameItem = t_nameItem;
						this._dObj.nameItems.push(t_nameItem);
					}
				}

				var t_half:uint = t_la / 2;
				this.p_lm_groups_setting(scope, stepIndex + 1, t_half);
			}
		}
		
		// :: LayerModule 체크후 화면표시 이후 실행 후 선택된 데이터 갱신하기
		private function p_lm_checkGoto_checkedUpdate():void
		{
			if (this._dObj.checkLayers != undefined)
			{
				var t_checkLayers:Array = null;
				var t_stepChecks:Array = null;
				var t_cl:CheckList = null;
				var t_la:uint, t_lb:uint;
				var i:uint, j:uint;

				t_checkLayers = this._dObj.checkLayers;
				t_la = t_checkLayers.length;
				for (i = 0; i < t_la; i++)
				{
					t_stepChecks = t_checkLayers[i];
					t_lb = t_stepChecks.length;
					for (j = 0; j < t_lb; j++)
					{
						t_cl = this._dObj.groupLayers[i][j];
						t_cl.selectedIndexDispatch = t_stepChecks[j];
					}
				}
			}
		}
		
		// :: LayerModule 편집모드 설정
		private function p_lm_check_editMode():void
		{
			if (this._dObj != null)
			{
				var t_tf:TextField = null;
				var t_nameItem:MovieClip = null;
				var t_la:uint = this._dObj.nameItems.length;
				var i:uint;

				if (this._topUiWrap.get_isEditMode())
				{
					t_tf = this._titleInfo.tf_1;
					t_tf.type = TextFieldType.INPUT;
					t_tf.selectable = true;
					t_tf.textColor = 0x333333;
					t_tf.background = true;
					t_tf.border = true;

					for (i = 0; i < t_la; i ++)
					{
						t_nameItem = this._dObj.nameItems[i];
						t_nameItem.mouseChildren = true;
						t_nameItem.mouseEnabled = true;
						t_tf = t_nameItem.tf;
						t_tf.type = TextFieldType.INPUT;
						t_tf.selectable = true;
						t_tf.border = true;
					}
				}
				else
				{
					t_tf = this._titleInfo.tf_1;
					t_tf.type = TextFieldType.DYNAMIC;
					t_tf.selectable = false;
					t_tf.textColor = 0xffffff;
					t_tf.background = false;
					t_tf.border = false;

					for (i = 0; i < t_la; i ++)
					{
						t_nameItem = this._dObj.nameItems[i];
						t_nameItem.mouseChildren = false;
						t_nameItem.mouseEnabled = false;
						t_tf = t_nameItem.tf;
						t_tf.type = TextFieldType.DYNAMIC;
						t_tf.selectable = false;
						t_tf.border = false;
					}
				}			
			}
		}
		
		// :: LayerModule 체크후 화면표시 이후
		private function p_lm_checkGoto_after():void
		{
			var t_tf:TextField = this._titleInfo.tf_1;
			t_tf.text = this._dObj.title;

			this._dObj.nameItems = [];
			this._dObj.groupLayers = [];
			
			this.p_lm_groups_setting(this._mapLayer, 0, int(this._dObj.layerType));			
			this._dObj.isNew = false;
			
			this._dObj.winnerClip = this._mapLayer.winnerCont_mc;
			this._dObj.winnerClip.mouseEnabled = false;
			this._dObj.winnerClip.mouseChildren = false;
			this._dObj.winnerClip.d_isOpen = false;
			
			this.p_lm_checkGoto_checkedUpdate();
			this.p_lm_check_editMode();
		}
		
		// :: LayerModule 체크후 화면표시
		private function p_lm_checkGoto():void
		{			
			var t_label:String = null;
			
			switch (this._dObj.layerType)
			{
				case '32':
				{
					t_label = '#_4';

					break;
				}

				case '16':
				{
					t_label = '#_3';

					break;
				}

				case '8':
				{
					t_label = '#_2';

					break;
				}

				case '4':
				{
					t_label = '#_1';

					break;
				}
			}
			
			this._mapLayer.gotoAndStop(t_label);
			MovieClipUtil.delayExcute(this._owner, this.p_lm_checkGoto_after);
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}