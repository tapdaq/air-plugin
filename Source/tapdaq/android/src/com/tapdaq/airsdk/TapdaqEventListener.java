package com.tapdaq.airsdk;


import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.listeners.TMAdListener;

import java.util.Map;

public class TapdaqEventListener extends TMAdListener {

    final private static String CALLBACK_DID_LOAD = "load";
    final private static String CALLBACK_DID_FAIL_LOAD= "failload";
    final private static String CALLBACK_DID_SHOW = "show";
    final private static String CALLBACK_DID_CLOSE = "close";
    final private static String CALLBACK_DID_REFRESH = "refresh";

    final private static String CALLBACK_DID_CUSTOM= "custom";

    private final String contextType;

    public TapdaqEventListener(String contextType) {
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

    @Override
    public void didRefresh() {
        dispatchEvent(CALLBACK_DID_REFRESH);
    }

    @Override
    public void didCustomEvent(Map<Object, Object> eventData) {
        dispatchEvent(CALLBACK_DID_CUSTOM, Utils.mapToString(eventData));
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
