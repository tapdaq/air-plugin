package com.tapdaq.airsdk.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.sdk.CreativeType;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.common.TMAdType;
import com.tapdaq.sdk.listeners.TMAdListener;

public class AirTapdaqLoadNativeAd implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            final String creativeTypeString = args[0].getAsString();
            CreativeType creativeType = Utils.parseCreativeTypeString(creativeTypeString);

            String placementTag = args[1].getAsString();

            final String finalPlacementTag = placementTag;
            TMAdListener listener = new TMAdListener(){

                @Override
                public void didLoad() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_LOADED, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didFailToLoad(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_FAIL_TO_LOAD, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, error));
                }

                @Override
                public void didRewardFail(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_REWARD_FAIL, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, error));
                }

                @Override
                public void willDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_WILL_DISPLAY, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_DISPLAY, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didClick() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLICK, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didClose() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLOSE, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didComplete() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_COMPLETE, Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didEngagement() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_ENGAGEMENT,  Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void onUserDeclined() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_ON_USER_DECLINED,  Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

                @Override
                public void didVerify(String location, String reward, Double value) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_VERIFY,  Utils.parseNativeAdEventData(TMAdType.NATIVE, creativeTypeString, finalPlacementTag, null));
                }

            };

            Tapdaq.getInstance().loadNativeAdvert(context.getActivity(), creativeType, placementTag, listener);
//
//            TMNativeAd ad = Tapdaq.getInstance().fetchNativeAd(Extension.appContext, creativeType, placementTag, new TMAdListener() {
//                @Override
//                public void onAdClosed() {
//                    Log.i(TAG, "nativeAd onAdClosed");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_CLOSED, Utils.parseAdEventData(TMAdType.NATIVE, null));
//                }
//
//                @Override
//                public void onAdFailedToLoad(TMAdError tmAdError) {
//                    Log.i(TAG, "nativeAd onAdFailedToLoad "+ Utils.parseTMAdError(tmAdError));
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_FAILED_TO_LOAD, Utils.parseAdEventData(TMAdType.NATIVE, tmAdError));
//                }
//
//                @Override
//                public void onAdClick() {
//                    Log.i(TAG, "nativeAd onAdClick");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_CLICK,Utils.parseAdEventData(TMAdType.NATIVE, null));
//                }
//
//                @Override
//                public void onAdOpened() {
//                    Log.i(TAG, "nativeAd onAdOpened");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_OPENED, Utils.parseAdEventData(TMAdType.NATIVE, null));
//                }
//
//                @Override
//                public void onAdLoaded() {
//                    Log.i(TAG, "nativeAd onAdLoaded");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_LOADED, Utils.parseAdEventData(TMAdType.NATIVE, null));
//                }
//            });
//
//            if(ad != null)
//            {
//                // get json string and send the data in the event
////                Extension.nativeAd = ad;
//                Extension.nativeAdsByCreativeTypePlacecementTag.put(creativeTypeString + "$" + placementTag, ad);
//                String nativeAdJSON = Utils.parseNativeAd(ad, creativeTypeString, placementTag);
//                context.dispatchStatusEventAsync(CommonEvents.AirTapdaqNativeAdEvent_AD_DATA, nativeAdJSON);
//            }
//            else
//            {
//                Log.i(TAG, "No native ads available for requested params in Tapdaq ANE");
//            }

        }
        catch (Exception e)
        {
        }

        return null;
    }
}
