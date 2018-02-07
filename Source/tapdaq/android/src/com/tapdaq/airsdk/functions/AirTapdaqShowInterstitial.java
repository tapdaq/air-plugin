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

public class AirTapdaqShowInterstitial implements FREFunction {

    public static final String TAG = "AirTapdaqShowInt";

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {

            String placementTag = args[0].getAsString();
            String adTypeString = args[1].getAsString();
            final int adType = TMAdType.getInt(adTypeString);

            if( placementTag.equals("") ) {
                // "default" placement tag
                placementTag = TapdaqPlacement.TDPTagDefault;
            }

            final String finalPlacementTag = placementTag;
            TMAdListener listener = new TMAdListener(){

//                @Override
//                public void didLoad() {
//                    Log.i(TAG, "interstitial didLoad");
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_AD_LOADED, Utils.parseAdEventData(adType, finalPlacementTag, null));
//                }

                @Override
                public void willDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_WILL_DISPLAY, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void didDisplay() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_DISPLAY, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void didClick() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLICK, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void didClose() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_CLOSE, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

//                @Override
//                public void didFailToLoad(TMAdError error) {
//                    Log.i(TAG, "interstitial onAdFailedToLoad "+ Utils.parseTMAdError(error));
//                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_FAIL_TO_LOAD, Utils.parseAdEventData(adType, finalPlacementTag, error));
//                }

                @Override
                public void didRewardFail(TMAdError error) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_REWARD_FAIL, Utils.parseAdEventData(adType, finalPlacementTag, error));
                }

                @Override
                public void didComplete() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_COMPLETE, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void didEngagement() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_ENGAGEMENT, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void onUserDeclined() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_ON_USER_DECLINED, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }

                @Override
                public void didVerify(String location, String reward, Double value) {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_DID_VERIFY, Utils.parseAdVerifyData(adType, location, reward, value));
                }
            };

            if (adType == TMAdType.STATIC_INTERSTITIAL)
            {
                if (Tapdaq.getInstance().isInterstitialReady(context.getActivity(), finalPlacementTag)) {
                    Tapdaq.getInstance().showInterstitial(context.getActivity(), placementTag, listener);
                } else {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_NOT_AVAILABLE, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }
            }
            else if (adType == TMAdType.VIDEO_INTERSTITIAL)
            {

                if (Tapdaq.getInstance().isVideoReady(context.getActivity(), finalPlacementTag)) {
                    Tapdaq.getInstance().showVideo(context.getActivity(), placementTag, listener);
                } else {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_NOT_AVAILABLE, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }
            }
            else if (adType == TMAdType.REWARD_INTERSTITIAL)
            {
                if (Tapdaq.getInstance().isRewardedVideoReady(context.getActivity(), finalPlacementTag)) {
                    Tapdaq.getInstance().showRewardedVideo(context.getActivity(), placementTag, listener);
                } else {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqAdEvent_NOT_AVAILABLE, Utils.parseAdEventData(adType, finalPlacementTag, null));
                }
            }

        }
        catch (Exception e)
        {
            context.dispatchStatusEventAsync(CommonEvents.LOGGING, "Error occurred while attempting to show static_interstitial Tapdaq ANE " + e.getLocalizedMessage());
        }

        return null;
    }
}
