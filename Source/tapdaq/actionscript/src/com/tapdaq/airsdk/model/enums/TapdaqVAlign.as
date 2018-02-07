package com.tapdaq.airsdk.model.enums {
public class TapdaqVAlign {


	/***************************
	 *
	 * PUBLIC
	 *
	 ***************************/


	// VALUES FROM android.view.Gravity
	static public const TOP               : TapdaqVAlign = new TapdaqVAlign(Private, 48);
	static public const BOTTOM  : TapdaqVAlign = new TapdaqVAlign(Private, 80);
	static public const CENTER   : TapdaqVAlign = new TapdaqVAlign(Private, 17);



	public function get value():int {
		return _value;
	}

	/***************************
	 *
	 * PRIVATE
	 *
	 ***************************/

	private var _value:int;

	public function TapdaqVAlign(access:Class, value:int) {

		if (access != Private)
			throw new Error("Private constructor call!");

		_value = value;
	}
}
}

final class Private {}
