package com.tapdaq.airsdk;

import com.adobe.fre.FREFunction;
import com.tapdaq.airsdk.functions.moreapps.IsMoreAppsAvailable;
import com.tapdaq.airsdk.functions.moreapps.LoadMoreApps;
import com.tapdaq.airsdk.functions.moreapps.ShowMoreApps;

import java.util.HashMap;
import java.util.Map;

public class MoreAppsContext extends TapdaqContext {

    public final static String TYPE = "moreapps";

    public MoreAppsContext(String contextType) {
        super(contextType);
    }

    private static TapdaqEventTempListener _eventListener;

    public static TapdaqEventTempListener getEventListener() {
        if (_eventListener == null) {
            _eventListener = new TapdaqEventTempListener(TYPE);
        }
        return _eventListener;
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
        functions.put(LOAD_FUNCTION_NAME, new LoadMoreApps());
        functions.put(AVAILABLE_FUNCTION_NAME, new IsMoreAppsAvailable());
        functions.put(SHOW_FUNCTION_NAME, new ShowMoreApps());
        return functions;
    }

    @Override
    public void dispose() {
    }
}
