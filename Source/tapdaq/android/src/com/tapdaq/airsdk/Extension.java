package com.tapdaq.airsdk;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.tapdaq.sdk.TMNativeAd;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;


public class Extension implements FREExtension{
    public static HashMap<String, TapdaqContext> contexts;
    public static Map<String, TMNativeAd> nativeAdsByCreativeTypePlacecementTag = new HashMap<String, TMNativeAd>();

    @Override
    public FREContext createContext(String contextType) {
            TapdaqContext heyzapContext = contexts.get(contextType);
            if (heyzapContext == null) {
                heyzapContext = TapdaqContext.Factory.build(contextType);
                contexts.put(contextType, heyzapContext);
            }

            return heyzapContext;
    }

    public static TapdaqContext getContext(String contextType) {
        if (contexts != null) {
            TapdaqContext context = contexts.get(contextType);
            return context;
        }
        return null;
    }

    @Override
    public void initialize() {
        contexts = new HashMap<String, TapdaqContext>();

    }

    @Override
    public void dispose() {
        contexts.clear();
        nativeAdsByCreativeTypePlacecementTag = null;
    }


    public static void log(String message) {
        if (contexts != null) {
            TapdaqContext context = contexts.get(TapdaqContext.TYPE);
            if (context != null) {
                context.dispatchStatusEventAsync("LOGGING", message);
            }
        }
    }

    public static void log(Throwable e) {
        if (e == null) {
            return;
        }

        StringWriter sWriter = new StringWriter();
        PrintWriter pWriter = new PrintWriter(sWriter);
        e.printStackTrace(pWriter);
        String strStackTrace = sWriter.toString();

        Extension.log("Exception: " + e.toString());
        Extension.log(strStackTrace);

        if (contexts != null) {
            TapdaqContext context = contexts.get(TapdaqContext.TYPE);
            if (context != null) {
                context.dispatchStatusEventAsync("LOGGING", "Exception: " + e.toString());
                context.dispatchStatusEventAsync("LOGGING", strStackTrace);
            }
        }
    }
}
