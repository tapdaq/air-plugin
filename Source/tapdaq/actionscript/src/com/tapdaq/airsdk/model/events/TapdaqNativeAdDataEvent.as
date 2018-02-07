package com.tapdaq.airsdk.model.events {
import com.tapdaq.airsdk.model.TapdaqNativeAd;

public class TapdaqNativeAdDataEvent extends TapdaqNativeAdEvent {
	static public const AD_DATA: String = "AirTapdaqNativeAdDataEvent_ad_data";
	private var _nativeAd:TapdaqNativeAd;

	public function TapdaqNativeAdDataEvent(type:String, nativeAd:TapdaqNativeAd, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, null, nativeAd.placementTag , null, bubbles, cancelable);
		this._nativeAd = nativeAd;
	}

	public function get nativeAd():TapdaqNativeAd {
		return _nativeAd;
	}
}
}
