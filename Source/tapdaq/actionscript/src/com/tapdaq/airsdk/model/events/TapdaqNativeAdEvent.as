package com.tapdaq.airsdk.model.events {
import com.tapdaq.airsdk.model.VOs.TapdaqAdError;
import com.tapdaq.airsdk.model.enums.TapdaqAdType;
import com.tapdaq.airsdk.model.enums.TapdaqCreativeType;

public class TapdaqNativeAdEvent extends TapdaqAdEvent {

	public function TapdaqNativeAdEvent(type:String, nativeAdType:TapdaqCreativeType, placementTag : String, error:TapdaqAdError, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, TapdaqAdType.NATIVE, placementTag, error, bubbles, cancelable);
	}
}
}
