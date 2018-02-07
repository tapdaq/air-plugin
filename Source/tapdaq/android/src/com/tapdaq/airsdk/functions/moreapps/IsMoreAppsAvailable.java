package com.tapdaq.airsdk.functions.moreapps;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.sdk.Tapdaq;


public class IsMoreAppsAvailable implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try
        {
            Boolean isAvailable = Tapdaq.getInstance().isMoreAppsReady(context.getActivity());
            return FREObject.newObject(isAvailable);
        } catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
