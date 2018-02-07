package com.tapdaq.airsdk.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.sdk.Tapdaq;

public class AirTapdaqStartTestActivity implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try  {
            Tapdaq.getInstance().startTestActivity(context.getActivity());
        }
        catch (Exception e) {
            context.dispatchStatusEventAsync(CommonEvents.LOGGING, "Error occurred while starting test activity" + e.getLocalizedMessage());
        }

        return null;
    }

}
