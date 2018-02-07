package com.tapdaq.airsdk.model.events {
import com.tapdaq.airsdk.model.VOs.TapdaqAdError;
import com.tapdaq.airsdk.model.enums.TapdaqAdType;

public class TapdaqVerifyAdEvent extends TapdaqAdEvent {
	private var _rewardName:String;
	private var _rewardAmount:Number;

	public function TapdaqVerifyAdEvent(type:String, adType:TapdaqAdType, placementTag : String, rewardName:String, rewardAmount:Number, error:TapdaqAdError, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, adType, placementTag, error, bubbles, cancelable);
		_rewardName = rewardName;
		_rewardAmount = rewardAmount;
	}

	public function get rewardName():String {
		return _rewardName;
	}

	public function get rewardAmount():Number {
		return _rewardAmount;
	}
}
}
