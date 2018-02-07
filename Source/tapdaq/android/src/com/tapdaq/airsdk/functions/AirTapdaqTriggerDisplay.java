package com.tapdaq.airsdk.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.sdk.TMNativeAd;
import com.tapdaq.sdk.helpers.TLog;

public class AirTapdaqTriggerDisplay implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        TLog.error("Trigger display");
        try {
            String uniqueId = args[0].getAsString();
            TMNativeAd nativeAd = Extension.nativeAdsByCreativeTypePlacecementTag.get(uniqueId);
            nativeAd.triggerDisplay(context.getActivity());
        } catch (Exception e) {
            // FIXME: add exception
        }
        return null;
    }
}
