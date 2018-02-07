package com.tapdaq.airsdk.model.VOs {
import com.tapdaq.airsdk.model.enums.TapdaqHAlign;
import com.tapdaq.airsdk.model.enums.TapdaqVAlign;

public class TapdaqBannerLayout {

	private var _hAlign:TapdaqHAlign = TapdaqHAlign.CENTER;
	private var _vAlign:TapdaqVAlign = TapdaqVAlign.BOTTOM;

	private var _marginTop:int = 0;
	private var _marginLeft:int = 0;
	private var _marginBottom:int = 0;
	private var _marginRight:int = 0;


	public function get hAlign():TapdaqHAlign {
		return _hAlign;
	}

	public function set hAlign(value:TapdaqHAlign):void {
		_hAlign = value;
	}

	public function get vAlign():TapdaqVAlign {
		return _vAlign;
	}

	public function set vAlign(value:TapdaqVAlign):void {
		_vAlign = value;
	}

	public function get marginTop():int {
		return _marginTop;
	}

	public function set marginTop(value:int):void {
		_marginTop = value;
	}

	public function get marginLeft():int {
		return _marginLeft;
	}

	public function set marginLeft(value:int):void {
		_marginLeft = value;
	}

	public function get marginBottom():int {
		return _marginBottom;
	}

	public function set marginBottom(value:int):void {
		_marginBottom = value;
	}

	public function get marginRight():int {
		return _marginRight;
	}

	public function set marginRight(value:int):void {
		_marginRight = value;
	}
}
}
