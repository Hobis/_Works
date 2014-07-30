const m_TITLE_NAME:String = 'TourLang Ver 1.02';

// :: TopUiBar 초기화
function p_topUiBar_init():void
{
	var t_str:String =
		File.applicationDirectory.nativePath +
		File.separator + '_Datas' +
		File.separator + 'default.' + m_EX_NAME;
	this.m_file = new File(t_str);
	this.m_file.addEventListener(Event.SELECT, this.p_topUiBar_file_select);
	this.m_fileStream = new FileStream();
	this.m_fileStream.addEventListener(Event.CLOSE, this.p_topUiBar_fileStream_close);
	this.m_fileStream.addEventListener(Event.COMPLETE, this.p_topUiBar_fileStream_complete);

	this.m_topUiBar.d_visible = false;
	this.m_topUiBar.d_isEditMode = false;
	this.m_topUiBar.d_isAutoClose = false;
	this.m_topUiBar.name_tf.text = m_TITLE_NAME;


	var t_bt:SimpleButton = null
	// {{{ 버튼들 이벤트 등록
	// 상단 Ui바 닫기 버튼
	t_bt = this.m_topUiBar.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_close_click);

	// 상단 Ui바 새로시작 버튼
	t_bt = this.m_topUiBar.new_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_new_click);

	// 상단 Ui바 불러오기 버튼
	t_bt = this.m_topUiBar.open_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_open_click);

	// 상단 Ui바 저장하기 버튼
	t_bt = this.m_topUiBar.save_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_save_click);

	// 상단 Ui바 스크린샷 버튼
	t_bt = this.m_topUiBar.shot_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_shot_click);

	// 상단 Ui바 뒤섞기 버튼
	t_bt = this.m_topUiBar.shuffling_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_shuffling_click);

	// 상단 Ui바 초기화 버튼
	t_bt = this.m_topUiBar.reset_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_reset_click);

	// 상단 Ui바 정보 버튼
	t_bt = this.m_topUiBar.info_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_info_click);
	// }}}


	var t_bl:ButtonLogic = null;
	// {{{ 편집모드 버튼
	t_bl = new ButtonLogic(this.m_topUiBar.editMode_mc, true);
	t_bl.addEventListener(MouseEvent.CLICK, this.p_topUiBar_editMode_click);
	//t_bl.selectedDispatch = true;
	this.m_topUiBar.d_editMode_bl = t_bl;
	// }}}

	// {{{ 자동닫기 버튼
	t_bl = new ButtonLogic(this.m_topUiBar.autoClose_mc, true);
	t_bl.addEventListener(MouseEvent.CLICK, this.p_topUiBar_autoClose_click);
	t_bl.selectedDispatch = true;
	this.m_topUiBar.d_autoClose_bl = t_bl;
	// }}}

	// {{{ 핀 버튼
	t_bt = this.m_topUiBar.pin_bt;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_pin_click);
	MovieClipUtil.delayExcute(this, this.p_topUiBar_pin_click, [null], 10);
	// }}}

	//DebugUtil.test('p_topUiBar_init');
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const m_EX_NAME:String = 'tbd';
var m_file:File = null;
var m_fileStream:FileStream = null;
var m_fileOpenType:String = null;

// - ScreenShot
var m_ssfile:File = null;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ PopUp 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: PopUp 알림 닫기버튼 클릭
function p_popUp_alert_close_click(event:MouseEvent):void
{
	this.p_popUp_close();

	//DebugUtil.test('p_popUp_alert_close_click');
}

// :: PopUp 알림 리셋
function p_popUp_alert_reset():void
{
	var t_panel:MovieClip = this.m_popUp.alert_mc;
	var t_tf:TextField = t_panel.body_tf;
	t_tf.text = '';

	//DebugUtil.test('p_popUp_alert_reset');
}

// :: PopUp 알림 패널 초기화
function p_popUp_alert_init():void
{
	var t_panel:MovieClip = this.m_popUp.alert_mc;
	t_panel.visible = false;

	var t_bt:SimpleButton = null;
	var t_tf:TextField = null;

	// {{{ 닫기버튼
	t_bt = t_panel.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_alert_close_click);
	// }}}

	t_tf = t_panel.body_tf;
	t_tf.text = '';

	// {{{ 확인버튼
	t_bt = t_panel.confirm_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_alert_close_click);
	// }}}

	//DebugUtil.test('p_popUp_alert_init');
}

// :: PopUp 프로젝트 정보 패널 닫기 버튼 클릭
function p_popUp_new_close_click(event:MouseEvent):void
{
	this.p_popUp_close();

	//DebugUtil.test('p_popUp_new_close_click');
}

// :: PopUp 프로젝트 정보 패널 Layer 타입 채인지(CheckList)
function p_popUp_new_layerType_change(event:CheckListEvent):void
{
	var t_cl:CheckList = event.currentTarget as CheckList;
	this.m_popUp.new_mc.d_layerTypeIndex = t_cl.selectedIndex;

	//DebugUtil.test('p_popUp_new_layerType_change');
	//DebugUtil.test('this.m_popUp.new_mc.d_layerTypeIndex: ' + this.m_popUp.new_mc.d_layerTypeIndex);
}

// :: PopUp 프로젝트 정보 패널 확인버튼 클릭
function p_popUp_new_confirm_click(event:MouseEvent):void
{
	var t_panel:MovieClip = this.m_popUp.new_mc;
	var t_tf:TextField = null;

	var t_dataObj:Object = new Object();

	t_tf = t_panel.name_tf;
	t_dataObj.name = t_tf.text;

	var t_str:String =
		this.m_file.parent.nativePath + File.separator +
		t_dataObj.name + '.' + m_EX_NAME;
	this.m_file = new File(t_str);
	this.m_file.addEventListener(Event.SELECT, this.p_topUiBar_file_select);

	t_tf = t_panel.title_tf;
	t_dataObj.title = t_tf.text;

	switch (t_panel.d_layerTypeIndex)
	{
		// 32강 선택
		case 0:
		{
			t_dataObj.layerType = '32';
			break;
		}

		// 16강 선택
		case 1:
		{
			t_dataObj.layerType = '16';
			break;
		}

		// 08강 선택
		case 2:
		{
			t_dataObj.layerType = '8';
			break;
		}

		// 04강 선택
		case 3:
		{
			t_dataObj.layerType = '4';
			break;
		}
	}

	t_dataObj.items = new Array();

	var t_la:uint = uint(t_dataObj.layerType);
	var i:uint;
	for (i = 0; i < t_la; i ++)
	{
		t_dataObj.items.push({name: ''});
	}

	if
	(
		(t_dataObj.name != undefined) &&
		(t_dataObj.title != undefined) &&
		(t_dataObj.layerType != undefined) &&
		(t_dataObj.items != undefined)
	)
	{
		this.p_layer_reset();
		t_dataObj.d_isNew = true;
		this.m_dataObj = t_dataObj;
		this.p_layer_checkGoto();
	}

	this.p_popUp_new_close_click(null);

	//DebugUtil.test('p_popUp_new_confirm_click');
	//DebugUtil.test('this.m_dataObj.title: ' + this.m_dataObj.title);
	//DebugUtil.test('this.m_dataObj.layerType: ' + this.m_dataObj.layerType);
	//DebugUtil.test('this.m_dataObj.items: ' + this.m_dataObj.items);
}

// :: PopUp 프로젝트 정보 패널 취소버튼 클릭
function p_popUp_new_cancel_click(event:MouseEvent):void
{
	this.p_popUp_new_close_click(null);

	//DebugUtil.test('p_popUp_new_cancel_click');
}

// :: PopUp 프로젝트 정보 패널 리셋
function p_popUp_new_reset():void
{
	var t_panel:MovieClip = this.m_popUp.new_mc;

	var t_tf:TextField = null;
	var t_cl:CheckList = null;
	var t_bl:ButtonLogic = null;

	t_tf = t_panel.name_tf;
	t_tf.text = t_panel.d_projectName;
	t_tf = t_panel.title_tf;
	t_tf.text = t_panel.d_titleName;

	t_cl = t_panel.d_layerType_cl;
	t_cl.selectedIndexDispatch = 0;

	//DebugUtil.test('p_popUp_new_reset');
}

// :: PopUp 프로젝트 정보 패널 초기화
function p_popUp_new_init():void
{
	var t_panel:MovieClip = this.m_popUp.new_mc;
	t_panel.visible = false;

	t_panel.d_projectName = 'Default';
	t_panel.d_titleName = 'Begin Tournament';

	var t_bt:SimpleButton = null;
	var t_tf:TextField = null;
	var t_cl:CheckList = null;
	var t_bl:ButtonLogic = null;

	// {{{ 닫기버튼
	t_bt = t_panel.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_new_close_click);
	// }}}

	// {{{ 프로젝트 명 입력
	t_tf = t_panel.name_tf;
	t_tf.text = t_panel.d_projectName;
	t_tf.maxChars = 18;
	// }}}

	// {{{ 타이틀 입력
	t_tf = t_panel.title_tf;
	t_tf.text = t_panel.d_titleName;
	t_tf.maxChars = 38;
	// }}}

	// {{{ 토너먼트 타입 CheckList
	var t_sels:Array =
	[
	 	t_panel.sel_1,
		t_panel.sel_2,
		t_panel.sel_3,
		t_panel.sel_4
	];
	t_cl = new CheckList(t_sels);
	t_cl.addEventListener(CheckListEvent.CHANGE, this.p_popUp_new_layerType_change);
	t_panel.d_layerTypeIndex = 0;
	t_cl.selectedIndexDispatch = t_panel.d_layerTypeIndex;
	t_panel.d_layerType_cl = t_cl;
	// }}}

	// {{{ 확인 클릭
	t_bt = t_panel.confirm_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_new_confirm_click);
	// }}}

	// {{{ 취소 클릭
	t_bt = t_panel.cancel_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_new_cancel_click);
	// }}}

	//DebugUtil.test('p_popUp_new_init');
}

// :: PopUp 프로그램 정보 패널 닫기 버튼 클릭
function p_popUp_info_close_click(event:MouseEvent):void
{
	this.p_popUp_close();

	//DebugUtil.test('p_popUp_info_close_click');
}

// :: PopUp 프로젝트 정보 패널 확인 버튼 클릭
function p_popUp_info_confirm_click(event:MouseEvent):void
{
	this.p_popUp_info_close_click(null);

	//DebugUtil.test('p_popUp_info_confirm_click');
}

// :: PopUp 프로그램 정보 패널 리셋
function p_popUp_info_reset():void
{
	//DebugUtil.test('p_popUp_info_reset');
}

// :: PopUp 프로그램 정보 패널 초기화
function p_popUp_info_init():void
{
	var t_panel:MovieClip = this.m_popUp.info_mc;
	t_panel.visible = false;

	var t_tf:TextField = null;

	t_tf = t_panel.name_tf;
	t_tf.text = 'Name: ' + m_TITLE_NAME;
	t_tf = t_panel.author_tf;
	t_tf.text = 'Programmed By: ' + 'HobisJung (http://blog.naver.com/jhb0b)';
	t_tf = t_panel.comment_tf;
	t_tf.text = 'Comment: \n' +
		'	본 프로그램은 Adobe AIR로 만들어진 토너먼트 관리 프로그램입니다.\n' +
		'	프로그램의 사용은 누구나 공개로 사용 할 수 있습니다.\n' +
		'	개선사항, 건의사항은 jhb0b@naver.com으로 문의 주세요.\n' +
		'	감사합니다. 제작자 올림.\n';


	var t_bt:SimpleButton = null;

	// {{{ 닫기버튼
	t_bt = t_panel.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_info_close_click);
	// }}}

	// {{{ 확인 클릭
	t_bt = t_panel.confirm_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_info_confirm_click);
	// }}}
}

// :: PopUp 확인 패널 닫기 버튼 클릭
function p_popUp_confirm_close_click(event:MouseEvent):void
{
	this.p_popUp_close();

	//DebugUtil.test('p_popUp_confirm_close_click');
}

// :: PopUp 확인 패널 확인 버튼 클릭
function p_popUp_confirm_confirm_click(event:MouseEvent):void
{
	if (this.m_popUp.d_afterFunc != undefined)
	{
		this.m_popUp.d_afterFunc();
	}

	this.p_popUp_confirm_close_click(null);

	//DebugUtil.test('p_popUp_confirm_confirm_click');
}

// :: PopUp 확인 패널 취소 버튼 클릭
function p_popUp_confirm_cancel_click(event:MouseEvent):void
{
	this.p_popUp_confirm_close_click(null);

	//DebugUtil.test('p_popUp_confirm_cancel_click');
}

// :: PopUp 확인 패널 리셋
function p_popUp_confirm_reset():void
{
	if (this.m_popUp.d_message != undefined)
		this.m_popUp.d_message = undefined;

	if (this.m_popUp.d_afterFunc != undefined)
		this.m_popUp.d_afterFunc = undefined;

	//DebugUtil.test('p_popUp_confirm_reset');
}

// :: PopUp 확인 패널 초기화
function p_popUp_confirm_init():void
{
	var t_panel:MovieClip = this.m_popUp.confirm_mc;
	t_panel.visible = false;

	var t_bt:SimpleButton = null;

	// {{{ 닫기버튼
	t_bt = t_panel.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_confirm_close_click);
	// }}}

	// {{{ 확인 클릭
	t_bt = t_panel.confirm_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_confirm_confirm_click);
	// }}}

	// {{{ 취소 클릭
	t_bt = t_panel.cancel_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_popUp_confirm_cancel_click);
	// }}}
}

// :: Popup 오픈 함수
function p_popUp_open(type:String):void
{
	var t_panel:MovieClip = null;

	switch (type)
	{
		// 알림
		case '#_0':
		{
			t_panel = this.m_popUp.alert_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}

		// 정보 입력
		case '#_1':
		{
			t_panel = this.m_popUp.new_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}

		// 프로그램 정보
		case '#_2':
		{
			t_panel = this.m_popUp.info_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}

		// 확인
		case '#_3':
		{
			t_panel = this.m_popUp.confirm_mc;
			t_panel.visible = true;

			if (this.m_popUp.d_message != undefined)
			{
				var t_tf:TextField = null;
				t_tf = t_panel.body_tf;
				t_tf.text = this.m_popUp.d_message;
			}

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;


			break;
		}
	}

	//DebugUtil.test('p_popUp_open');
}

// :: PopUp 패널 리셋
function p_popUp_panel_reset(panel:MovieClip):void
{
	switch (panel)
	{
		case this.m_popUp.alert_mc:
		{
			this.p_popUp_alert_reset();
			break;
		}

		case this.m_popUp.new_mc:
		{
			this.p_popUp_new_reset();
			break;
		}

		case this.m_popUp.info_mc:
		{
			this.p_popUp_info_reset();
			break;
		}

		case this.m_popUp.confirm_mc:
		{
			this.p_popUp_confirm_reset();
			break;
		}
	}

	//DebugUtil.test('p_popUp_panel_reset');
}

// :: Popup 닫기 함수
function p_popUp_close():void
{
	this.m_popUp.visible = false;

	if (this.m_popUp.d_nowOpen != null)
	{
		this.m_popUp.d_nowOpen.visible = false;
		this.p_popUp_panel_reset(this.m_popUp.d_nowOpen);
		this.m_popUp.d_nowOpen = null;
	}

	//DebugUtil.test('p_popUp_close');
}

// :: PopUp 초기화
function p_popUp_init():void
{
	this.m_popUp.visible = false;
	this.m_popUp.d_nowOpen = null;

	this.p_popUp_alert_init();
	this.p_popUp_new_init();
	this.p_popUp_info_init();
	this.p_popUp_confirm_init();

	//DebugUtil.test('p_popUp_init');
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ 메인 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: 메인 초기화
function p_init_once():void
{
	// {{{ Default Setting
	// - Stage Setting
	var t_stage:Stage = this.stage;
	t_stage.scaleMode = StageScaleMode.NO_SCALE;
	//t_stage.scaleMode = StageScaleMode.SHOW_ALL;
	t_stage.align = StageAlign.TOP_LEFT;

	// - AIR Native Setting
	var t_title:String = 'TourLang';
	var t_win:NativeWindow = this.stage.nativeWindow;
	t_win.title = t_title;
	// }}}

	this.m_popUp = this.popUp_mc;
	this.m_topUiBar = this.topUiBar_mc;

	this.m_titleInfo = this.titleInfo_mc;
	this.m_mapLayer = this.mapLayer_mc;


	this.p_popUp_init();
	this.p_topUiBar_init();
	this.p_layer_init();

	TweenPlugin.activate([TintPlugin]);

	//DebugUtil.test('p_init_once');
}

// -
var owner:MovieClip = this;

// - 현재 모든 결과정보를 담는 객체
var m_dataObj:Object = null;
/*
var m_dataObj:Object = null;
{
	name: 'Default',
	title: 'Microsoft XBOX Halo Reach Tournament',
	layerType: '32',
	items:
	[
	 	{
			name: '마재윤'
		}
	]
};
*/

// - Name아이템 배열
var m_nameItems:Array = null;
// - GroupLayer 배열
var m_groupLayers:Array = null;

// - 팝업 컨테이너
var m_popUp:MovieClip = null;
// - 상단 UiBar컨테이너
var m_topUiBar:MovieClip = null;

// - 타이틀 정보
var m_titleInfo:MovieClip = null;
// - 맵레이어 무비클립
var m_mapLayer:MovieClip = null;


this.p_init_once();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
