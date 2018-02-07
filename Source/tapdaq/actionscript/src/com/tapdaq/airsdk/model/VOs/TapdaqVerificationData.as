package com.tapdaq.airsdk.model.VOs {
public class TapdaqVerificationData {

	private var _placementTag:String;
	private var _rewardName:String;
	private var _rewardAmount:Number;

	public function TapdaqVerificationData(placementTag:String, rewardName:String, rewardAmount:Number) {
		_placementTag = placementTag;
		_rewardName = rewardName;
		_rewardAmount = rewardAmount;
	}

	public function get placementTag():String {
		return _placementTag;
	}

	public function get rewardName():String {
		return _rewardName;
	}

	public function get rewardAmount():Number {
		return _rewardAmount;
	}
}
}
