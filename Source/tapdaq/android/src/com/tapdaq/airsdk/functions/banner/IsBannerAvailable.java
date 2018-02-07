package com.tapdaq.airsdk.functions.banner;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.BannerContext;
import com.tapdaq.airsdk.Extension;


public class IsBannerAvailable implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            Boolean isAvailable = BannerContext.bannerAdView != null;
            return FREObject.newObject(isAvailable);
        } catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
