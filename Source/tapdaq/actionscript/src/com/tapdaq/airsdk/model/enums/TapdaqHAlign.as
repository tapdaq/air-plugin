package com.tapdaq.airsdk.model.enums {
public class TapdaqHAlign {


	/***************************
	 *
	 * PUBLIC
	 *
	 ***************************/


	// VALUES FROM android.view.Gravity
	static public const LEFT               : TapdaqHAlign = new TapdaqHAlign(Private, 3);
	static public const RIGHT  : TapdaqHAlign = new TapdaqHAlign(Private, 5);
	static public const CENTER   : TapdaqHAlign = new TapdaqHAlign(Private, 17);



	public function get value():int {
		return _value;
	}

	/***************************
	 *
	 * PRIVATE
	 *
	 ***************************/

	private var _value:int;

	public function TapdaqHAlign(access:Class, value:int) {

		if (access != Private)
			throw new Error("Private constructor call!");

		_value = value;
	}
}
}

final class Private {}
