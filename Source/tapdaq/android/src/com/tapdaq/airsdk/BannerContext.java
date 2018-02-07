package com.tapdaq.airsdk;

import android.widget.PopupWindow;

import com.adobe.fre.FREFunction;
import com.tapdaq.airsdk.functions.banner.HideBanner;
import com.tapdaq.airsdk.functions.banner.IsBannerAvailable;
import com.tapdaq.airsdk.functions.banner.LoadBanner;
import com.tapdaq.airsdk.functions.banner.ShowBanner;
import com.tapdaq.sdk.TMBannerAdView;
import com.tapdaq.sdk.listeners.TMAdListener;

import java.util.HashMap;
import java.util.Map;

public class BannerContext extends TapdaqContext {
    public final static String TYPE = "banner";
    private static TapdaqEventListener _eventListener;

    public static PopupWindow popupWindow;
    public static TMBannerAdView bannerAdView;

    public BannerContext(String contextType) {
        super(contextType);
    }

    public static TMAdListener getEventListener() {
        if (_eventListener == null) {
            _eventListener = new TapdaqEventListener(TYPE);
        }
        return _eventListener;
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
        functions.put(LOAD_FUNCTION_NAME, new LoadBanner());
        functions.put(SHOW_FUNCTION_NAME, new ShowBanner());
        functions.put(HIDE_FUNCTION_NAME, new HideBanner());
        functions.put(AVAILABLE_FUNCTION_NAME, new IsBannerAvailable());

        return functions;
    }

    @Override
    public void dispose() {
    }
}
