package com.tapdaq.airsdk.functions.offerwall;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.OfferwallContext;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.listeners.TMAdListener;


public class ShowOfferwall implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try
        {
            if(Tapdaq.getInstance().isOfferwallReady(context.getActivity())) {
                Tapdaq.getInstance().showOfferwall(context.getActivity(), OfferwallContext.getEventListener());
            } else {
                Extension.log("Offerwall isn't ready!");
            }
        }
        catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
