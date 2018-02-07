package com.tapdaq.airsdk;

import com.adobe.fre.FREFunction;
import com.tapdaq.airsdk.functions.offerwall.IsOfferwallAvailable;
import com.tapdaq.airsdk.functions.offerwall.LoadOfferwall;
import com.tapdaq.airsdk.functions.offerwall.ShowOfferwall;
import com.tapdaq.sdk.listeners.TMAdListenerBase;

import java.util.HashMap;
import java.util.Map;

public class OfferwallContext extends TapdaqContext {

    public final static String TYPE = "offerwall";

    public OfferwallContext(String contextType) {
        super(contextType);
    }

    private static TapdaqEventListener _eventListener;

    public static TMAdListenerBase getEventListener() {
        if (_eventListener == null) {
            _eventListener = new TapdaqEventListener(TYPE);
        }

        return _eventListener;
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
        functions.put(AVAILABLE_FUNCTION_NAME, new IsOfferwallAvailable());
        functions.put(LOAD_FUNCTION_NAME, new LoadOfferwall());
        functions.put(SHOW_FUNCTION_NAME, new ShowOfferwall());
        return functions;
    }

    @Override
    public void dispose() {
    }
}
