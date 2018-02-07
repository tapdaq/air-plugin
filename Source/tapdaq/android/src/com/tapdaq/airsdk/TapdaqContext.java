package com.tapdaq.airsdk;

import android.content.res.Configuration;
import android.util.Log;

import com.adobe.air.AndroidActivityWrapper;
import com.adobe.air.AndroidStateChangeListener;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.tapdaq.airsdk.functions.AirTapdaqGetNativeAd;
import com.tapdaq.airsdk.functions.AirTapdaqInit;
import com.tapdaq.airsdk.functions.AirTapdaqLoadInterstitial;
import com.tapdaq.airsdk.functions.AirTapdaqLoadNativeAd;
import com.tapdaq.airsdk.functions.AirTapdaqShowInterstitial;
import com.tapdaq.airsdk.functions.AirTapdaqStartTestActivity;
import com.tapdaq.airsdk.functions.AirTapdaqTriggerClick;
import com.tapdaq.airsdk.functions.AirTapdaqTriggerDisplay;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.helpers.TLog;

import java.util.HashMap;
import java.util.Map;

public class TapdaqContext extends FREContext implements AndroidStateChangeListener{

    public final static String TYPE = "tapdaq";
    public final static String LOAD_FUNCTION_NAME = "load";
    public final static String SHOW_FUNCTION_NAME = "show";
    public final static String HIDE_FUNCTION_NAME = "hide";
    public final static String AVAILABLE_FUNCTION_NAME = "available";

    private String contextType;

    public TapdaqContext(String contextType) {
        super();
        this.contextType = contextType;
    }

    @Override
    public void onActivityStateChanged(AndroidActivityWrapper.ActivityState state) {
        TLog.debug("Activity state changed to " + state.toString());

        if (state == AndroidActivityWrapper.ActivityState.PAUSED) Tapdaq.getInstance().onPause(getActivity());
        else if (state == AndroidActivityWrapper.ActivityState.RESUMED) Tapdaq.getInstance().onResume(getActivity());
    }

    @Override
    public void onConfigurationChanged(Configuration var1) {

    }

    public static class Factory {
        public static TapdaqContext build(String contextType) {
            TapdaqContext context = null;

            if (contextType.equals(OfferwallContext.TYPE)) {
                context = new OfferwallContext(contextType);
            } else if (contextType.equals(MoreAppsContext.TYPE)) {
                context = new MoreAppsContext(contextType);
            } else if (contextType.equals(BannerContext.TYPE)) {
                context = new BannerContext(contextType);
            } else if (contextType.equals(TYPE)) {
                context = new TapdaqContext(contextType);
            }
            return context;
        }
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
        functions.put("AirTapdaqInit", new AirTapdaqInit());
        functions.put("AirTapdaqLoadInterstitial", new AirTapdaqLoadInterstitial());
        functions.put("AirTapdaqShowInterstitial", new AirTapdaqShowInterstitial());
        functions.put("AirTapdaqLoadNativeAd", new AirTapdaqLoadNativeAd());
        functions.put("AirTapdaqGetNativeAd", new AirTapdaqGetNativeAd());
        functions.put("AirTapdaqTriggerClick", new AirTapdaqTriggerClick());
        functions.put("AirTapdaqTriggerDisplay", new AirTapdaqTriggerDisplay());
        functions.put("AirTapdaqStartTestActivity", new AirTapdaqStartTestActivity());
        return functions;
    }

    @Override
    public void dispose() {
        if (Extension.contexts != null) {
            Extension.contexts.remove(this.contextType);
        }
    }

}
