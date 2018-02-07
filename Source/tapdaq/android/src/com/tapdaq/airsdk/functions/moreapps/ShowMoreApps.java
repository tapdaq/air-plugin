package com.tapdaq.airsdk.functions.moreapps;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.MoreAppsContext;
import com.tapdaq.sdk.Tapdaq;


public class ShowMoreApps implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try
        {
            if(Tapdaq.getInstance().isMoreAppsReady(context.getActivity())) {
                Tapdaq.getInstance().showMoreApps(context.getActivity(), MoreAppsContext.getEventListener());
            } else {
                Extension.log("MoreApps isn't ready!");
            }
        }
        catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
