package com.tapdaq.airsdk.model.VOs {
public class TapdaqAdError {
	private var _code:int;
	private var _message:String;
	public function TapdaqAdError(code:int, message:String) {
		_code = code;
		_message = message;
	}
	public function get code():int {
		return _code;
	}

	public function get message():String {
		return _message;
	}
}
}
