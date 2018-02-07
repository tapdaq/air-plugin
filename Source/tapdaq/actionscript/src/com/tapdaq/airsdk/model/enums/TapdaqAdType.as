package com.tapdaq.airsdk.model.enums {
public class TapdaqAdType {

    public static const BANNER               : TapdaqAdType = new TapdaqAdType("banner");
    public static const STATIC_INTERSTITIAL  : TapdaqAdType = new TapdaqAdType("static_interstitial");
    public static const VIDEO_INTERSTITIAL   : TapdaqAdType = new TapdaqAdType("video_interstitial");
    public static const REWARD_INTERSTITIAL  : TapdaqAdType = new TapdaqAdType("rewarded_video_interstitial");
    public static const NATIVE               : TapdaqAdType = new TapdaqAdType("native");

    private var _value : String = null;

    public function TapdaqAdType(value:String) {
        _value = value;
    }


	public static function fromValue(value:String):TapdaqAdType {

		switch (value) {
			case BANNER.value:
				return BANNER;
				break;
			case STATIC_INTERSTITIAL.value:
				return STATIC_INTERSTITIAL;
				break;
			case VIDEO_INTERSTITIAL.value:
				return VIDEO_INTERSTITIAL;
				break;
			case REWARD_INTERSTITIAL.value:
				return REWARD_INTERSTITIAL;
			case NATIVE.value:
				return NATIVE;
				break;
			default:
				return null;
			break;
		}
	}

	public function get value():String {
		return _value;
	}


}
}

