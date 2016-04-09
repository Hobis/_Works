import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.net.URLRequest;
import hbworks.uilogics.SliderLogicFrame;
import works.TKSound;
import tools.TxtTool;



var owner:MovieClip = this;
var _tks:TKSound = null;
var _snd:Sound = new Sound();
_snd.addEventListener(Event.COMPLETE,
	function(event:Event):void
	{
		_tks = new TKSound(_snd);
		_tks.set_callBack(
			function(eObj:Object):void
			{
				switch (eObj.type)
				{
				case TKSound.CT_PLAYING:
					var t_ratio:Number = _tks.get_pos() / _tks.get_length();
					_sfl1.set_ratio(t_ratio);
					break;
				}
			}
		);
	}
);
_snd.load(new URLRequest('./Data/Default_Sounds/XXXX.mp3'));
var _sfl1:SliderLogicFrame = new SliderLogicFrame(owner.slider_1, null, SliderLogicFrame.TYPE_HORIZONTAL);
_sfl1.onCallBack = function(eObj:Object):void
{
	switch (eObj.type)
	{
	case SliderLogicFrame.EVENT_TYPE_MOUSE_UP:
		var t_st:Number = _tks.get_length() * _sfl1.get_ratio();
		_tks.play(t_st);
		break;
	case SliderLogicFrame.EVENT_TYPE_MOUSE_DOWN:
		_tks.stop();
		break;
	case SliderLogicFrame.EVENT_TYPE_UPDATE:
		break;
	}
};


// 1 첨부터재생
SimpleButton(owner.pbt_1).addEventListener(MouseEvent.CLICK,
	function(event:MouseEvent):void
	{
		_tks.play(0);
		_tks.set_volume(0.3);
	}
);

// 2 재생
SimpleButton(owner.pbt_2).addEventListener(MouseEvent.CLICK,
	function(event:MouseEvent):void
	{
	}
);

// 3 일시정지
SimpleButton(owner.pbt_3).addEventListener(MouseEvent.CLICK,
	function(event:MouseEvent):void
	{

	}
);

// 4 완전정지
SimpleButton(owner.pbt_4).addEventListener(MouseEvent.CLICK,
	function(event:MouseEvent):void
	{
		_tks.get_pos();
	}
);

















/*

var _do:Sprite = this;
trace(_do['pbt_1']);
_do['pbt_222'] = '와 설마 오진다';
trace(_do['pbt_222']);
*/
/*
import flash.display.MovieClip;
import hbworks.uilogics.SliderLogicFrame;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.events.Event;
import hb.media.SimpleSound;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

var owner:MovieClip = this;
var _sfl1:SliderLogicFrame = new SliderLogicFrame(owner.slider_1, null, SliderLogicFrame.TYPE_HORIZONTAL);
_sfl1.onCallBack = function(eObj:Object):void
{
	switch (eObj.type)
	{
		case SliderLogicFrame.EVENT_TYPE_UPDATE:
		{
			//_ss.setPosition(_ss.getSound().length * _sfl1.get_ratio());
			if (_sfl1.get_ratio() < _sfl2.get_ratio())
			{
				_sfl1.set_ratio(_sfl2.get_ratio());
			}
			else
			if (_sfl1.get_ratio() > _sfl3.get_ratio())
			{
				_sfl1.set_ratio(_sfl3.get_ratio());
			}
			break;
		}
	}
};
var _sfl2:SliderLogicFrame = new SliderLogicFrame(owner.slider_2, null, SliderLogicFrame.TYPE_HORIZONTAL);
_sfl2.onCallBack = function(eObj:Object):void
{
	switch (eObj.type)
	{
		case SliderLogicFrame.EVENT_TYPE_UPDATE:
		{
			if (_sfl2.get_ratio() > _sfl3.get_ratio())
			{
				_sfl2.set_ratio(_sfl3.get_ratio());
			}
			_sfl1.onCallBack(eObj);
			break;
		}
	}
};
var _sfl3:SliderLogicFrame = new SliderLogicFrame(owner.slider_3, null, SliderLogicFrame.TYPE_HORIZONTAL);
_sfl3.onCallBack = function(eObj:Object):void
{
	switch (eObj.type)
	{
		case SliderLogicFrame.EVENT_TYPE_UPDATE:
		{
			if (_sfl3.get_ratio() < _sfl2.get_ratio())
			{
				_sfl3.set_ratio(_sfl2.get_ratio());
			}
			_sfl1.onCallBack(eObj);
			break;
		}
	}
};

var _snd:Sound = new Sound();
_snd.addEventListener(Event.COMPLETE,
	function(event:Event):void
	{
		//_snd.play();
	}
);
_snd.load(new URLRequest('./Data/Default_Sounds/XXXX.mp3'));

var _ss:SimpleSound = new SimpleSound();
_ss.autoPlay = true;

_ss.load('./Data/Default_Sounds/XXXX.mp3');


SimpleButton(owner.pbt_1).addEventListener(MouseEvent.CLICK,
	function(event:MouseEvent):void
	{
		trace(_ss.getSound().length);
		_ss.setPosition(81100);
	}
);
*/