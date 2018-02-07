package com.tapdaq.airsdk.functions.offerwall;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.OfferwallContext;
import com.tapdaq.sdk.Tapdaq;


public class LoadOfferwall implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try
        {
            Tapdaq.getInstance().loadOfferwall(context.getActivity(), OfferwallContext.getEventListener());
        } catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
