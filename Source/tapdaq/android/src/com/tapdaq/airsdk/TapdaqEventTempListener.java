package com.tapdaq.airsdk;


import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.listeners.TMAdListener;
import com.tapdaq.sdk.moreapps.TMMoreAppsListener;

import java.util.Map;

public class TapdaqEventTempListener extends TMMoreAppsListener {

    final private static String CALLBACK_DID_LOAD = "load";
    final private static String CALLBACK_DID_FAIL_LOAD= "failload";
    final private static String CALLBACK_DID_SHOW = "show";
    final private static String CALLBACK_DID_CLOSE = "close";

    private final String contextType;

    public TapdaqEventTempListener(String contextType) {
        this.contextType = contextType;
    }

    @Override
    public void didLoad() {
        dispatchEvent(CALLBACK_DID_LOAD);
    }

    @Override
    public void didFailToLoad(TMAdError error) {
        dispatchEvent(CALLBACK_DID_FAIL_LOAD, error.getErrorMessage());
    }

    @Override
    public void didDisplay() {
        dispatchEvent(CALLBACK_DID_SHOW);
    }

    @Override
    public void didClose() {
        dispatchEvent(CALLBACK_DID_CLOSE);
    }

    public void dispatchEvent(String name) {
        dispatchEvent(name, "");
    }

    public void dispatchEvent(String name, String tag) {
        tag = tag != null ? tag : "";
        TapdaqContext context = Extension.getContext(this.contextType);
        if (context != null) {
            context.dispatchStatusEventAsync(name, tag);
        }
    }
}
