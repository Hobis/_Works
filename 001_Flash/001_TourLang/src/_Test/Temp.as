import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.FileFilter;
import flash.text.TextField;
import flash.utils.ByteArray;
import com.adobe.images.PNGEncoder;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.TweenLite;
import com.greensock.easing.*;
import hb.utils.DebugUtil;
import hb.utils.NumberUtil;
import hb.utils.MovieClipUtil;
import hbworks.uilogics.ButtonLogic;
import hbworks.uilogics.CheckList;
import hbworks.uilogics.events.CheckListEvent;
import hb.utils.StringUtil;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ Tournament Layer 모듈 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: Layer 모듈 편집모드 설정
function p_layer_check_editMode():void
{
	var t_tf:TextField = null;
	var t_nameItem:MovieClip = null;
	var t_la:uint = this.m_nameItems.length;
	var i:uint;

	if (this.m_topUiBar.d_isEditMode)
	{
		t_tf = this.m_titleInfo.title_tf;
		t_tf.type = TextFieldType.INPUT;
		t_tf.selectable = true;
		t_tf.textColor = 0x333333;
		t_tf.background = true;
		t_tf.border = true;

		for (i = 0; i < t_la; i ++)
		{
			t_nameItem = this.m_nameItems[i];
			t_nameItem.mouseChildren = true;
			t_nameItem.mouseEnabled = true;
			t_tf = t_nameItem.tf;
			t_tf.type = TextFieldType.INPUT;
			t_tf.selectable = true;
			//t_tf.textColor = 0x333333;
			//t_tf.background = true;
			t_tf.border = true;
		}
	}
	else
	{
		t_tf = this.m_titleInfo.title_tf;
		t_tf.type = TextFieldType.DYNAMIC;
		t_tf.selectable = false;
		t_tf.textColor = 0xffffff;
		t_tf.background = false;
		t_tf.border = false;

		for (i = 0; i < t_la; i ++)
		{
			t_nameItem = this.m_nameItems[i];
			t_nameItem.mouseChildren = false;
			t_nameItem.mouseEnabled = false;
			t_tf = t_nameItem.tf;
			t_tf.type = TextFieldType.DYNAMIC;
			t_tf.selectable = false;
			//t_tf.textColor = 0xffffff;
			//t_tf.background = false;
			t_tf.border = false;
		}
	}
}

// :: Layer 모듈
function p_layer_cl_checkOver(type:String, target:DisplayObject, stepIndex:int):void
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

	if (type == 'bg')
		TweenLite.to(target, t_TWEEN_SEC, {tint: t_OVER_COLORS[stepIndex].bgc});
	else if (type == 'tf')
		TweenLite.to(target, t_TWEEN_SEC, {tint: t_OVER_COLORS[stepIndex].tfc});
}

// :: Layer 모듈
function p_layer_cl_checkOverItems(t_checkInfoObj:Object):void
{
	var t_check:MovieClip = null;
	var t_line:MovieClip = null;
	var t_la:uint, i:uint;

	for
	(
		i = 0, t_la = t_checkInfoObj.items.length;
		i < t_la; i ++
	)
	{
		t_check = t_checkInfoObj.items[i];
		if (i == 0)
		{
			if (t_check.d_nameItem != undefined)
			{
				if (t_checkInfoObj.lastStepIndex == 0)
				{
					this.p_layer_cl_checkOver('tf', t_check.d_nameItem.tf, 0);
					this.p_layer_cl_checkOver('bg', t_check.d_nameItem.d_bg, 0);
				}
				else
				{
					this.p_layer_cl_checkOver('tf', t_check.d_nameItem.tf, t_checkInfoObj.lastStepIndex);
					this.p_layer_cl_checkOver('bg', t_check.d_nameItem.d_bg, t_checkInfoObj.lastStepIndex);
				}
			}
		}
		t_line = t_check.d_line;
		this.p_layer_cl_checkOver('bg', t_line, t_checkInfoObj.lastStepIndex);
	}
}

// :: Layer 모듈 현재 선택된 연결고리를 상위 방향으로 찾기
function p_layer_cl_getCheckSelectedTopObj(check:MovieClip):Object
{
	var t_checkInfoObj:Object = null;

	var t_cl:CheckList = null;
	var t_bl:ButtonLogic = null;
	var t_check:MovieClip = check;

	var t_toStepIndex:uint = this.m_groupLayers.length - 1;
	var i:uint, j:uint;

	// i는 연결고리의 stepIndex, j는 연결고리의 itemIndex
	i = t_check.d_stepIndex;
	j = t_check.d_checkIndex;
	for (; i <= t_toStepIndex; i ++)
	{
		j = Math.floor(j / 2);

		if (i == t_check.d_stepIndex)
		{
			if (t_checkInfoObj == null)
			{
				t_checkInfoObj = new Object();
				t_checkInfoObj.items = new Array();
				t_checkInfoObj.lastStepIndex = -1;
			}

			t_checkInfoObj.items.push(t_check);
			t_checkInfoObj.lastStepIndex = i;
		}
		else
		{
			t_cl = this.m_groupLayers[i][j];
			//DebugUtil.test('t_cl.selectedIndex: ' + t_cl.selectedIndex);
			//DebugUtil.test('t_check.d_topSelectedIndex: ' + t_check.d_topSelectedIndex);
			if (t_cl.selectedIndex == t_check.d_topSelectedIndex)
			{
				t_bl = t_cl.selectedItem;
				if (t_bl != null)
				{
					t_check = t_bl.target;
					t_checkInfoObj.items.push(t_check);
					t_checkInfoObj.lastStepIndex = i;

					//DebugUtil.test('t_check.name: ' + t_check.name);
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

// :: Layer 모듈 현재 선택된 위치에서 StepIndex 0까지 Index 검색
function p_layer_cl_getCheckSelectedDown(check:MovieClip):MovieClip
{
	var t_rv:MovieClip = null;

	var t_cl:CheckList = null;
	var t_bl:ButtonLogic = null;
	var t_check:MovieClip = check;

	var i:uint, j:uint;

	for (i = t_check.d_stepIndex; i > 0; i --)
	{
		j = i - 1;

		t_cl = this.m_groupLayers[j][t_check.d_checkIndex];
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

// :: Layer 모듈 CheckList Winner Open
function p_layer_cl_click_openWinner(lastIndex:int):void
{
	var t_isLast:Boolean = false;
	if (this.m_dataObj.layerType == '32')
		t_isLast = (lastIndex == 5);
	else if (this.m_dataObj.layerType == '16')
		t_isLast = (lastIndex == 4);
	else if (this.m_dataObj.layerType == '8')
		t_isLast = (lastIndex == 3);
	else if (this.m_dataObj.layerType == '4')
		t_isLast = (lastIndex == 2);

	if (t_isLast)
	{
		TweenLite.to(this.m_winnerCont, .3,
		{
			alpha: 1,
			onInitParams: [this.m_winnerCont],
			onInit: function(target:MovieClip):void
			{
				target.visible = true;
				target.alpha = 0;
			}
		});
	}

	DebugUtil.test('p_layer_cl_click_openWinner');
}

// :: Layer 모듈 CheckList Winner Close
function p_layer_cl_click_closeWinner(stepIndex:int):void
{
	var t_isLast:Boolean = false;
	if (this.m_dataObj.layerType == '32')
		t_isLast = (stepIndex == 4);
	else if (this.m_dataObj.layerType == '16')
		t_isLast = (stepIndex == 3);
	else if (this.m_dataObj.layerType == '8')
		t_isLast = (stepIndex == 2);
	else if (this.m_dataObj.layerType == '4')
		t_isLast = (stepIndex == 1);

	if (t_isLast)
	{
		// 닫을때 사용하세요.
		TweenLite.to(this.m_winnerCont, .3,
		{
			alpha: 0,
			onCompleteParams: [this.m_winnerCont],
			onComplete: function(target:MovieClip):void
			{
				target.visible = false;
			}
		});
	}

	DebugUtil.test('p_layer_cl_click_closeWinner');
}

// :: Layer 모듈 CheckList 선택
function p_layer_cl_click(event:CheckListEvent):void
{
	var t_cl:CheckList = event.currentTarget as CheckList;
	var t_bl:ButtonLogic = null;
	var t_check:MovieClip = null;
	//
	var t_checkInfoObj:Object = null;
	var t_downCheck:MovieClip = null;

	if (event.yetIndex > -1)
	{
		t_bl = t_cl.getItemAt(event.yetIndex);
		t_check = t_bl.target;

		t_checkInfoObj = this.p_layer_cl_getCheckSelectedTopObj(t_check);
		t_checkInfoObj.lastStepIndex = 0;
		this.p_layer_cl_checkOverItems(t_checkInfoObj);

		t_downCheck = this.p_layer_cl_getCheckSelectedDown(t_check);
		if (t_downCheck != null)
		{
			if (t_downCheck.d_stepIndex == 0)
			{
				t_checkInfoObj = this.p_layer_cl_getCheckSelectedTopObj(t_downCheck);
				t_checkInfoObj.lastStepIndex += 1;
				this.p_layer_cl_checkOverItems(t_checkInfoObj);
			}
		}

		//this.p_layer_cl_click_closeWinner(t_check.d_stepIndex);
	}

	if (event.selectedIndex > -1)
	{
		t_bl = t_cl.selectedItem;
		t_check = t_bl.target;

		if (t_check.d_stepIndex == 0)
		{
			t_checkInfoObj = this.p_layer_cl_getCheckSelectedTopObj(t_check);
			t_checkInfoObj.lastStepIndex += 1;
			this.p_layer_cl_checkOverItems(t_checkInfoObj);
			this.p_layer_cl_click_openWinner(t_checkInfoObj.lastStepIndex);
		}
		else
		{
			t_downCheck = this.p_layer_cl_getCheckSelectedDown(t_check);
			if (t_downCheck != null)
			{
				if (t_downCheck.d_stepIndex == 0)
				{
					t_checkInfoObj = this.p_layer_cl_getCheckSelectedTopObj(t_downCheck);
					t_checkInfoObj.lastStepIndex += 1;
					this.p_layer_cl_checkOverItems(t_checkInfoObj);
					this.p_layer_cl_click_openWinner(t_checkInfoObj.lastStepIndex);
				}

				DebugUtil.test('t_downCheck.name: ' + t_downCheck.name);
				DebugUtil.test('t_downCheck.d_stepIndex: ' + t_downCheck.d_stepIndex);
				DebugUtil.test('t_downCheck.d_itemIndex: ' + t_downCheck.d_itemIndex);
			}
		}

//		DebugUtil.test('t_cl.name: ' + t_cl.name);
//		DebugUtil.test('t_check.name: ' + t_check.name);
//		DebugUtil.test('t_check.d_stepIndex: ' + t_check.d_stepIndex);
//		DebugUtil.test('t_check.d_checkIndex: ' + t_check.d_checkIndex);
//		DebugUtil.test('t_check.d_itemIndex: ' + t_check.d_itemIndex);
//		DebugUtil.test('t_check.d_topSelectedIndex: ' + t_check.d_topSelectedIndex);
	}

	if (t_check != null)
	{
		if (t_cl != null)
		{
			if (this.m_dataObj.checkLayers != undefined)
			{
				var t_arr:Array = this.m_dataObj.checkLayers[t_check.d_stepIndex];
				t_arr[t_check.d_itemIndex] = t_cl.selectedIndex;

				DebugUtil.test('this.m_dataObj.checkLayers: ' + this.m_dataObj.checkLayers);
			}
		}
	}

	//DebugUtil.test('p_layer_cl_click');
}

// :: Layer 모듈 네임아니템 텍스트필드 채인지 이벤트
function p_layer_nameItem_change(event:Event):void
{
	if (this.m_dataObj != null)
	{
		var t_tf:TextField = event.currentTarget as TextField;
		var t_nameItem:MovieClip = t_tf.parent as MovieClip;
		var t_index:int = StringUtil.getLastIndex2(t_nameItem.name);

		var t_item:Object = this.m_dataObj.items[t_index];
		t_item.name = t_tf.text;


		//DebugUtil.test('t_index: ' + t_index);
		//DebugUtil.test('t_item: ' + t_item);
		//DebugUtil.test('t_item.name: ' + t_item.name);
	}

	//DebugUtil.test('p_layer_nameItem_change');
}

// :: Layer 모듈 그룹스 셋팅
function p_layer_groups_setting(scope:MovieClip, stepIndex:uint, len:uint):void
{
	if (NumberUtil.getIsOddEven(Number(len)))
	{
		DebugUtil.test('짝수가 아닙니다.');
	}
	else
	{
		var t_stepGroups:Array = new Array();
		this.m_groupLayers.push(t_stepGroups);


		var t_stepChecks:Array = null;
		if (this.m_dataObj.d_isNew)
		{
			if (this.m_dataObj.checkLayers == undefined)
				this.m_dataObj.checkLayers = new Array();

			t_stepChecks = new Array();
			this.m_dataObj.checkLayers.push(t_stepChecks);
		}
		else
		{
			//t_stepChecks = this.m_dataObj.checkLayers[stepIndex];
		}

		var t_group:Array = null;
		var t_nameItem:MovieClip = null;
		var t_tf:TextField = null;
		var t_check:MovieClip = null;
		var t_cl:CheckList = null;

		var t_div:uint = 2;
		var t_la:uint = len, i:uint, j:uint = 0;
		var t_a:uint;

		for (i = 0; i < t_la; i ++)
		{
			t_check = scope['check_' + stepIndex + '_' + i];
			t_check.tabEnabled = false;
			t_check.d_line = scope['line_' + stepIndex + '_' + i];

			t_a = i % 2;
			if (t_a == 0)
			{
				t_group = new Array();
				t_group.push(t_check);
			}
			else
			{
				t_group.push(t_check);
				t_cl = new CheckList(t_group);
				t_cl.isToggleMode = true;
				t_cl.name = 'cl_' + stepIndex + '_' + (j ++);
				t_cl.addEventListener(CheckListEvent.CHANGE, this.p_layer_cl_click);
				t_stepGroups.push(t_cl);

				if (this.m_dataObj.d_isNew)
				{
					t_stepChecks.push(-1);
				}
				else
				{
					//t_cl.selectedIndex = t_stepChecks[Math.floor(i / 2)];
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
				t_tf.text = this.m_dataObj.items[i].name;
				t_tf.tabIndex = i;
				t_tf.addEventListener(Event.CHANGE, this.p_layer_nameItem_change);
				t_nameItem.tabEnabled = false;
				t_nameItem.d_bg = t_nameItem.getChildAt(0) as Shape;
				t_check.d_nameItem = t_nameItem;
				this.m_nameItems.push(t_nameItem);
			}
		}

		var t_half:uint = t_la / 2;
		this.p_layer_groups_setting(scope, stepIndex + 1, t_half);


		//DebugUtil.test('짝수가 맞습니다.');
		//DebugUtil.test('t_la: ' + t_la);
		//DebugUtil.test('t_half: ' + t_half);
	}

	//DebugUtil.test('p_layer_groups_setting');
}

// :: Layer 모듈 타이틀 텍스트 변경 이벤트
function p_layer_title_change(event:Event):void
{
	if (this.m_dataObj != null)
	{
		var t_tf:TextField = event.currentTarget as TextField;
		this.m_dataObj.title = t_tf.text;
	}

	//DebugUtil.test('p_layer_title_change');
}

// :: Layer 모듈 체크후 화면표시 잠시후 실행 후 선택된 데이터 갱신하기
function p_layer_checkGoto_checkedUpdate():void
{
	if (this.m_dataObj.checkLayers != undefined)
	{
		var t_checkLayers:Array = null;
		var t_stepChecks:Array = null;
		var t_cl:CheckList = null;
		var t_la:uint, t_lb:uint;
		var i:uint, j:uint;

		t_checkLayers = this.m_dataObj.checkLayers;
		t_la = t_checkLayers.length;
		for (i = 0; i < t_la; i ++)
		{
			t_stepChecks = t_checkLayers[i];
			t_lb = t_stepChecks.length;
			for (j = 0; j < t_lb; j ++)
			{
				t_cl = this.m_groupLayers[i][j];
				t_cl.selectedIndexDispatch = t_stepChecks[j];
			}
		}
	}
}

// :: Layer 모듈 체크후 화면표시 잠시후 실행
function p_layer_checkGoto_afterCall(event:Event):void
{
	this.removeEventListener(event.type, this.p_layer_checkGoto_afterCall);

	var t_tf:TextField = this.m_titleInfo.title_tf;
	t_tf.addEventListener(Event.CHANGE, this.p_layer_title_change);
	t_tf.text = this.m_dataObj.title;

	this.m_nameItems = new Array();
	this.m_groupLayers = new Array();
	this.p_layer_groups_setting(this.m_mapLayer, 0, int(this.m_dataObj.layerType));
	this.m_dataObj.d_isNew = false;
	this.m_winnerCont = this.m_mapLayer.winnerCont_mc;
	this.m_winnerCont.mouseEnabled = false;
	this.m_winnerCont.mouseChildren = false;
	this.m_winnerCont.visible = false;
	this.p_layer_checkGoto_checkedUpdate();
	this.p_layer_check_editMode();

	//trace(this.m_dataObj.d_isNew);
	//DebugUtil.test('p_layer_checkGoto_afterCall');
}

// :: Layer 모듈 체크후 화면표시
function p_layer_checkGoto():void
{
	var t_label:String = '#_' + this.m_dataObj.layerType;
	this.m_mapLayer.gotoAndStop(t_label);

	this.addEventListener(Event.ENTER_FRAME, this.p_layer_checkGoto_afterCall);

	//DebugUtil.test('p_layer_checkGoto');
	//DebugUtil.test('t_label: ' + t_label);
}

// :: Layer 모듈 리셋
function p_layer_reset():void
{
	var t_la:uint, i:uint;

	if (this.m_nameItems != null)
	{
		var t_nameItem:MovieClip = null;
		var t_tf:TextField = null;

		t_la = this.m_nameItems.length;
		for (i = 0; i < t_la; i ++)
		{
			t_nameItem = this.m_nameItems[i];
			t_nameItem.d_bg = null;
			t_tf = t_nameItem.tf;
			t_tf.text = '';
			t_tf.removeEventListener(Event.CHANGE, this.p_layer_nameItem_change);
		}

		this.m_nameItems = null;
	}

	if (this.m_groupLayers != null)
	{
		var t_stepGroups:Array = null;
		var t_cl:CheckList = null;
		var t_bls:Array = null;
		var t_bl:ButtonLogic = null;
		var t_check:MovieClip = null;
		var t_lb:uint, j:uint;
		var t_lc:uint, k:uint;

		t_la = this.m_groupLayers.length;
		for (i = 0; i < t_la; i ++)
		{
			t_stepGroups = this.m_groupLayers[i];

			t_lb = t_stepGroups.length;
			for (j = 0; j < t_lb; j ++)
			{
				t_cl = t_stepGroups[j];
				t_cl.removeEventListener(CheckListEvent.CHANGE, this.p_layer_cl_click);
				t_bls = t_cl.items;

				t_lc = t_bls.length;
				for (k = 0; k < t_lc; k ++)
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

		this.m_groupLayers = null;
	}

	this.m_dataObj = null;

	this.m_mapLayer.gotoAndStop('#_0');

	//DebugUtil.test('p_layer_reset');
}

// :: Layer 모듈 초기화
function p_layer_init():void
{
	//DebugUtil.test('p_layer_init');
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ TopUiBar 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: TopUiBar 닫기 버튼 클릭
function p_topUiBar_close_click(event:MouseEvent):void
{
	if (this.m_topUiBar.d_visible)
	{
		this.p_topUiBar_pin_click(null);
	}

	//DebugUtil.test('p_topUiBar_close_click');
}

// :: TopUiBar 새로시작 버튼 클릭
function p_topUiBar_new_click(event:MouseEvent):void
{
	this.p_openPopUp('#_1');

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_new_click');
}

// :: TopUiBar 불러오기 버튼 클릭
function p_topUiBar_open_click(event:MouseEvent):void
{
	this.m_fileOpenType = 'open';
	var t_ff:FileFilter = new FileFilter('TourLang Binary Data: ', '*.' + this.m_exName + ';');
	this.m_file.browseForOpen('Open', [t_ff]);

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_open_click');
}

// :: TopUiBar 저장하기 버튼 클릭
function p_topUiBar_save_click(event:MouseEvent):void
{
	if (this.m_dataObj != null)
	{
		this.m_fileOpenType = 'save';
		this.m_file.browseForSave('Save As');
	}

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_save_click');
}

// :: TopUiBar 뒤섞기 버튼 클릭
function p_topUiBar_shuffling_click(event:MouseEvent):void
{
	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_shuffling_click');
}

// :: TopUiBar 스크린샷 버튼 클릭
function p_topUiBar_shot_click_select(event:Event):void
{
	var t_file:File = event.currentTarget as File;

	if (t_file.extension == null)
	{
		var t_uri:String = t_file.nativePath + '.png';
		t_file = new File(t_uri);

		var t_fs:FileStream = new FileStream();
		t_fs.open(t_file, FileMode.WRITE);
		t_fs.writeBytes(this.m_ba, 0, this.m_ba.bytesAvailable);
		t_fs.close();

		this.m_ba.clear();
	}

	DebugUtil.test('t_file.nativePath: ' + t_file.nativePath);
	DebugUtil.test('t_file.extension: ' + t_file.extension);
	DebugUtil.test('t_file.name: ' + t_file.name);
}

var m_ba:ByteArray = null;
// :: TopUiBar 스크린샷 버튼 클릭
function p_topUiBar_shot_click(event:MouseEvent):void
{
	var t_bd:BitmapData = new BitmapData(800, 700, false, 0xff292929);
	t_bd.draw(this.m_mapLayer);

	var t_ba:ByteArray = PNGEncoder.encode(t_bd);
	this.m_ba = t_ba;

	if (this.m_ssfile == null)
	{
		this.m_ssfile = new File();
		this.m_ssfile.addEventListener(Event.SELECT, this.p_topUiBar_shot_click_select);
	}
	var t_ff:FileFilter = new FileFilter('Save for png', '*.png;');
	this.m_ssfile.browseForSave('Save Image');

	//DebugUtil.test('p_topUiBar_shot_click');
}

// :: TopUiBar 소개말 버튼 클릭
function p_topUiBar_info_click(event:MouseEvent):void
{
	this.p_openPopUp('#_2');

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_info_click');
}

// :: TopUiBar 우승표시 닫기 버튼 클릭
function p_topUiBar_winnerClose_click(event:MouseEvent):void
{
	// 닫을때 사용하세요.
	TweenLite.to(this.m_winnerCont, .3,
	{
		alpha: 0,
		onCompleteParams: [this.m_winnerCont],
		onComplete: function(target:MovieClip):void
		{
			target.visible = false;
		}
	});

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_winnerClose_click');
}

// :: TopUiBar 편집모드 버튼로직 클릭
function p_topUiBar_editMode_click(event:MouseEvent):void
{
	var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
	this.m_topUiBar.d_isEditMode = t_bl.selected;

	if (this.m_nameItems != null)
		this.p_layer_check_editMode();

	if (this.m_topUiBar.d_isAutoClose)
		this.p_topUiBar_close_click(null);

	//DebugUtil.test('p_topUiBar_editMode_click');
}

// :: TopUiBar 자동닫기 버튼로직 클릭
function p_topUiBar_autoClose_click(event:MouseEvent):void
{
	var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
	this.m_topUiBar.d_isAutoClose = t_bl.selected;

	//DebugUtil.test('p_topUiBar_autoClose_click');
}

// :: TopUiBar 핀 버튼 클릭
function p_topUiBar_pin_click(event:MouseEvent):void
{
	if (this.m_topUiBar.d_visible)
	{
		TweenLite.to(this.m_topUiBar, .3,
			{y: -(this.m_topUiBar.height - 11), ease: Quint.easeOut});

		this.m_topUiBar.d_visible = false;
	}
	else
	{
		TweenLite.to(this.m_topUiBar, .3,
			{y: 0, ease: Quint.easeOut});

		this.m_topUiBar.d_visible = true;
	}

	//DebugUtil.test('p_topUiBar_pin_click');
	//DebugUtil.test('this.m_topUiBar.d_visible: ' + this.m_topUiBar.d_visible);
}

// :: TopUiBar 파일스트림 클로즈 핸들러
function p_topUiBar_fileStream_close(event:Event):void
{
    //DebugUtil.test('p_topUiBar_fileStream_close');
}

// :: TopUiBar 파일스트림 오픈 핸들러
function p_topUiBar_fileStream_complete(event:Event):void
{
	if (this.m_file.exists)
	{
		this.p_layer_reset();

		this.m_dataObj = this.m_fileStream.readObject();
		this.m_fileStream.close();

		if (this.m_dataObj.checkLayers == undefined)
			this.m_dataObj.d_isNew = true;
		this.p_layer_checkGoto();
	}

    //DebugUtil.test('p_topUiBar_fileStream_complete');
}

// :: TopUiBar 파일 오픈 핸들러
function p_topUiBar_file_select(event:Event):void
{
	if (this.m_fileOpenType != null)
	{
		switch (this.m_fileOpenType)
		{
			case 'open':
			{
				this.m_fileStream.openAsync(this.m_file, FileMode.READ);

				break;
			}

			case 'save':
			{
				if (this.m_file.extension != this.m_exName)
				{
					var t_parent:File = this.m_file.parent;
					this.m_file = t_parent.resolvePath(this.m_file.name + '.' + this.m_exName);

					//DebugUtil.test('t_parent.nativePath: ' + t_parent.nativePath);
					//DebugUtil.test('this.m_file.nativePath: ' + this.m_file.nativePath);
				}

				this.m_fileStream.openAsync(this.m_file, FileMode.WRITE);
				this.m_fileStream.writeObject(this.m_dataObj);
				this.m_fileStream.close();

				break;
			}
		}

		//DebugUtil.test('this.m_fileOpenType: ' + this.m_fileOpenType);

		this.m_fileOpenType = null;
	}

	//DebugUtil.test('p_topUiBar_file_select');
}

// :: TopUiBar 초기화
function p_topUiBar_init():void
{
	var t_str:String =
		File.applicationDirectory.nativePath + File.separator +
		'_Datas' + File.separator + 'default.' + this.m_exName;
	this.m_file = new File(t_str);
	this.m_file.addEventListener(Event.SELECT, this.p_topUiBar_file_select);
	this.m_fileStream = new FileStream();
	this.m_fileStream.addEventListener(Event.CLOSE, this.p_topUiBar_fileStream_close);
	this.m_fileStream.addEventListener(Event.COMPLETE, this.p_topUiBar_fileStream_complete);

	this.m_topUiBar.d_visible = false;
	this.m_topUiBar.d_isEditMode = false;
	this.m_topUiBar.d_isAutoClose = false;

	this.m_topUiBar.name_tf.text = 'TourLang Ver 0.16 beta';

	var t_bt:SimpleButton = null
	// {{{ 버튼들 이벤트 드옥
	t_bt = this.m_topUiBar.close_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_close_click);
	t_bt = this.m_topUiBar.new_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_new_click);
	t_bt = this.m_topUiBar.open_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_open_click);
	t_bt = this.m_topUiBar.save_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_save_click);
	t_bt = this.m_topUiBar.shuffling_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_shuffling_click);
	t_bt = this.m_topUiBar.shot_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_shot_click);
	t_bt = this.m_topUiBar.info_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_info_click);
	t_bt = this.m_topUiBar.winnerClose_bt;
	t_bt.tabEnabled = false;
	t_bt.addEventListener(MouseEvent.CLICK, this.p_topUiBar_winnerClose_click);
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
	this.p_topUiBar_pin_click(null);
	// }}}

	//DebugUtil.test('p_topUiBar_init');
}

var m_exName:String = 'tbd';
var m_file:File = null;
var m_fileStream:FileStream = null;
var m_fileOpenType:String = null;

// - ScreenShot
var m_ssfile:File = null;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ PopUp 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: PopUp 알림 닫기버튼 클릭
function p_popUp_alert_close_click(event:MouseEvent):void
{
	this.p_closePopUp();

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
	this.p_closePopUp();

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
		t_dataObj.name + '.' + this.m_exName;
	this.m_file = new File(t_str);
	this.m_file.addEventListener(Event.SELECT, this.p_topUiBar_file_select);

	t_tf = t_panel.title_tf;
	t_dataObj.title = t_tf.text;

	switch (t_panel.d_layerTypeIndex)
	{
		case 0:
		{
			t_dataObj.layerType = '32';
			break;
		}
		case 1:
		{
			t_dataObj.layerType = '16';
			break;
		}
		case 2:
		{
			t_dataObj.layerType = '8';
			break;
		}
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
	//DebugUtil.test('this.m_dataObj.name: ' + this.m_dataObj.name);
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
	 	t_panel.sel_0,
		t_panel.sel_1,
		t_panel.sel_2,
		t_panel.sel_3
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
	this.p_closePopUp();

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
	t_tf.text ='Name: ' + 'TourLang Ver 0.16 beta';
	t_tf = t_panel.author_tf;
	t_tf.text ='Programming: ' + 'HobisJung';
	t_tf = t_panel.comment_tf;
	t_tf.text ='Comment: \n' +
		'	본 프로그램은 Adobe AIR로 만들어진 토너먼트 관리 프로그램입니다.\n' +
		'	프로그램의 사용은 누구나 공개로 사용 할 수 있습니다.\n' +
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
	}

	//DebugUtil.test('p_popUp_panel_reset');
}

// :: PopUp 초기화
function p_popUp_init():void
{
	this.m_popUp.visible = false;
	this.m_popUp.d_nowOpen = null;

	this.p_popUp_alert_init();
	this.p_popUp_new_init();
	this.p_popUp_info_init();

	//DebugUtil.test('p_popUp_init');
}

// :: Popup 오픈 함수
function p_openPopUp(type:String):void
{
	var t_panel:MovieClip = null;

	switch (type)
	{
		case '#_0':
		{
			t_panel = this.m_popUp.alert_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}
		case '#_1':
		{
			t_panel = this.m_popUp.new_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}
		case '#_2':
		{
			t_panel = this.m_popUp.info_mc;
			t_panel.visible = true;

			this.m_popUp.d_nowOpen = t_panel;
			this.m_popUp.visible = true;

			break;
		}
	}

	//DebugUtil.test('p_openPopUp');
}

// :: Popup 닫기 함수
function p_closePopUp():void
{
	this.m_popUp.visible = false;

	if (this.m_popUp.d_nowOpen != null)
	{
		this.m_popUp.d_nowOpen.visible = false;
		this.p_popUp_panel_reset(this.m_popUp.d_nowOpen);
		this.m_popUp.d_nowOpen = null;
	}

	//DebugUtil.test('p_closePopUp');
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// {{{ 메인 초기화
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// :: 메인 초기화
function p_main_init():void
{
	// {{{ Default Setting
	// - Stage Setting
	this.stage.scaleMode = StageScaleMode.NO_SCALE;
	//this.stage.scaleMode = StageScaleMode.SHOW_ALL;
	this.stage.align = StageAlign.TOP_LEFT;

	// - AIR Native Setting
	var t_title:String = 'TourLang';
	var t_win:NativeWindow = this.stage.nativeWindow;
	t_win.title = t_title;
	// }}}

	this.m_mainCont = this.mainCont_mc;
	this.m_popUp = this.m_mainCont.popUp_mc;
	this.m_topUiBar = this.m_mainCont.topUiBar_mc;

	this.m_titleInfo = this.mainCont_mc.titleInfo_mc;
	this.m_mapLayer = this.m_mainCont.mapLayer_mc;

	this.p_popUp_init();
	this.p_topUiBar_init();
	this.p_layer_init();

	TweenPlugin.activate([TintPlugin]);

	//DebugUtil.test('p_main_init');
}


// - 현재 모든 결과정보를 담는 객체
var m_dataObj:Object = null;
/*
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

// - 메인 컨테이너
var m_mainCont:MovieClip = null;
// - 팝업 컨테이너
var m_popUp:MovieClip = null;
// - 상단 UiBar컨테이너
var m_topUiBar:MovieClip = null;

// - 타이틀 정보
var m_titleInfo:MovieClip = null;
// - 맵레이어 무비클립
var m_mapLayer:MovieClip = null;
// - 우승
var m_winnerCont:MovieClip = null;

this.p_main_init();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
