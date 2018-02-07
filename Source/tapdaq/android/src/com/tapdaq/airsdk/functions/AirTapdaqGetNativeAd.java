package com.tapdaq.airsdk.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.sdk.CreativeType;
import com.tapdaq.sdk.TMNativeAd;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.common.TMAdType;
import com.tapdaq.sdk.listeners.TMAdListener;

public class AirTapdaqGetNativeAd implements FREFunction {
    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try
        {
            String creativeTypeString = args[0].getAsString();
            CreativeType creativeType = Utils.parseCreativeTypeString(creativeTypeString);

            String placementTag = args[1].getAsString();

            final String finalPlacementTag = placementTag;

            TMAdListener listener = new TMAdListener(){

                @Override
                public void didLoad() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_LOADED, Utils.parseAdEventData(TMAdType.NATIVE, finalPlacementTag, null));
                }

                @Override
                public void didFailToLoad(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_FAIL_TO_LOAD, Utils.parseAdEventData(TMAdType.NATIVE, finalPlacementTag, error));
                }

                @Override
                public void didRewardFail(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_REWARD_FAIL, Utils.parseAdEventData(TMAdType.NATIVE, finalPlacementTag, error));
                }

                @Override
                public void willDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_WILL_DISPLAY, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_DISPLAY, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didClick() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLICK, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didClose() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLOSE, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didComplete() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_COMPLETE, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didEngagement() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_ENGAGEMENT, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void onUserDeclined() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_ON_USER_DECLINED, Utils.parseAdEventData(TMAdType.NATIVE, "", null));
                }

                @Override
                public void didVerify(String location, String reward, Double value) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_VERIFY, Utils.parseAdVerifyData(TMAdType.NATIVE, location, reward, value));
                }
            };

            TMNativeAd ad = Tapdaq.getInstance().getNativeAdvert(context.getActivity(), creativeType, placementTag, listener);

            if(ad != null)  {
                // get json string and send the data in the event
                String uniqueId = creativeTypeString + "-" + ad.getID();
                Extension.nativeAdsByCreativeTypePlacecementTag.put(uniqueId, ad);
                String nativeAdJSON = Utils.parseNativeAd(ad, placementTag, uniqueId);
                context.dispatchStatusEventAsync(CommonEvents.AirTapdaqNativeAdDataEvent_AD_DATA, nativeAdJSON);
            }
            else {
                context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_NOT_AVAILABLE, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
            }

        }
        catch (Exception e)
        {
            context.dispatchStatusEventAsync(CommonEvents.LOGGING, "Error occurred while attempting to fetch native ad Tapdaq ANE " + e.getLocalizedMessage());
        }

        return null;
    }
}
