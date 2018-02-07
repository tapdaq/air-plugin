package com.tapdaq.airsdk.model.events {
import com.tapdaq.airsdk.model.PlacementTag;
import com.tapdaq.airsdk.model.VOs.TapdaqAdError;
import com.tapdaq.airsdk.model.enums.TapdaqAdType;

import flash.events.Event;

public class TapdaqAdEvent extends Event {

	static public const AD_LOADED :String = "AirTapdaqAdEvent_onAdLoaded";
	static public const WILL_DISPLAY :String = "AirTapdaqAdEvent_onWillDisplay";
	static public const DID_DISPLAY :String = "AirTapdaqAdEvent_onDidDisplay";
	static public const DID_CLICK :String = "AirTapdaqAdEvent_onDidClick";
	static public const DID_CLOSE :String = "AirTapdaqAdEvent_onDidClose";
	static public const DID_FAIL_TO_LOAD :String = "AirTapdaqAdEvent_onDidFailToLoad";
	static public const DID_COMPLETE :String = "AirTapdaqAdEvent_onDidComplete";
	static public const DID_ENGAGEMENT :String = "AirTapdaqAdEvent_onDidEngagement";
	static public const ON_USER_DECLINED :String = "AirTapdaqAdEvent_onUserDeclined";
	static public const DID_VERIFY :String = "AirTapdaqAdEvent_onDidVerify";
	static public const NOT_AVAILABLE :String = "AirTapdaqAdEvent_onNotAvailable";
	static public const DID_REWARD_FAIL :String = "AirTapdaqAdEvent_onDidRewardFail";

	public var error:TapdaqAdError;
	public var adType:TapdaqAdType;
	public var placementTag :String;

	public function TapdaqAdEvent(type:String, adType:TapdaqAdType, placementTag : String, error:TapdaqAdError, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, bubbles, cancelable);
		this.adType = adType;
		this.placementTag = placementTag;
		this.error = error;
	}
}
}
