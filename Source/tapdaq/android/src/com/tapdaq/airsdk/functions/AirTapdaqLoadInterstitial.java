package com.tapdaq.airsdk.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.ads.TapdaqPlacement;
import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.common.TMAdType;
import com.tapdaq.sdk.listeners.TMAdListener;

public class AirTapdaqLoadInterstitial implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try  {

            String placementTag = args[0].getAsString();
            String adTypeString = args[1].getAsString();
            final int adType = TMAdType.getInt(adTypeString);

            if( placementTag.equals("") ) {
                // "default" placement tag
                placementTag = TapdaqPlacement.TDPTagDefault;
            }

            final String finalPlacementTag = placementTag;
            TMAdListener listener = new TMAdListener(){
//                @Override                             TODO ?
//                public void setAutoRetry(boolean value) {
//                    super.setAutoRetry(value);
//                }
//
//                @Override
//                public boolean shouldAutoRetry() {
//                    return super.shouldAutoRetry();
//                }

                @Override
                public void didLoad() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_LOADED, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

//                @Override
//                public void didRewardFail(TMAdError error) {
//                    Log.i(TAG, "interstitial didRewardFail "+ Utils.parseTMAdError(error));
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_REWARD_FAIL, Utils.parseAdEventData(adType, finalPlacementTag, error));
//                }

//                @Override
//                public void willDisplay() {
//                    Log.i(TAG, "interstitial willDisplay");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_WILL_DISPLAY, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }
//
//                @Override
//                public void didDisplay() {
//                    Log.i(TAG, "interstitial didDisplay");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_DISPLAY, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }

//                @Override
//                public void didClick() {
//                    Log.i(TAG, "interstitial didClick");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLICK, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }
//
//                @Override
//                public void didClose() {
//                    Log.i(TAG, "interstitial didClose");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLOSE, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }

                @Override
                public void didFailToLoad(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_FAIL_TO_LOAD, Utils.parseAdEventData(adType, finalPlacementTag, error));
                }
//
//                @Override
//                public void didComplete() {
//                    Log.i(TAG, "interstitial didComplete");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_COMPLETE, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }
//
//                @Override
//                public void didEngagement() {
//                    Log.i(TAG, "interstitial didEngagement");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_ENGAGEMENT, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }
//
//                @Override
//                public void onUserDeclined() {
//                    Log.i(TAG, "interstitial onUserDeclined");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_ON_USER_DECLINED, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }
//
//                @Override
//                public void didVerify(String location, String reward, Double value) {
//                    Log.i(TAG, "interstitial didVerify");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_VERIFY, Utils.parseAdVerifyData(adType, location, reward, value));
//                }
            };
            if (adType == TMAdType.STATIC_INTERSTITIAL)  {
                // load static interstitial
                Tapdaq.getInstance().loadInterstitial(context.getActivity(), placementTag, listener);
            } else if (adType == TMAdType.VIDEO_INTERSTITIAL) {
                // load video interstitial
                Tapdaq.getInstance().loadVideo(context.getActivity(), placementTag, listener);
            } else if (adType == TMAdType.REWARD_INTERSTITIAL) {
                // load rewarded video interstitial
                Tapdaq.getInstance().loadRewardedVideo(context.getActivity(), placementTag, listener);
            }
        } catch (Exception e) {
            context.dispatchStatusEventAsync(CommonEvents.LOGGING, "Error occurred while attempting to load interstitial in Tapdaq ANE " + e.getLocalizedMessage());
        }

        return null;
    }
}
