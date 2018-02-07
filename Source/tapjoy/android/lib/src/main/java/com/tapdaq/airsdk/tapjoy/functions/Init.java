package com.tapdaq.airsdk.tapjoy.functions;

import android.content.res.Resources;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.tapjoy.Extension;
import com.tapjoy.TapjoyUtil;

import java.io.InputStream;

public class Init implements FREFunction {
    private FREContext context;

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        this.context = context;
        try {
            Log.d(Extension.TAG,"Initing tapjoy!!!");
            readResources();
        }catch (Exception e) {
            Log.e("TapJoy",e.getLocalizedMessage());
        }
        return null;
    }

    private void readResources(){
        Log.i(Extension.TAG,"Loading resources....");
        TapjoyUtil.setResource("mraid.js", new String(loadResource("raw.mraid")));
        TapjoyUtil.setResource("tj_close_button.png", loadResource("raw.tj_close_button"));
        TapjoyUtil.setResource("countdown_image.png", loadResource("raw.countdown_image"));
    }

    private byte[] loadResource (String name) {
        try {
            Resources res = context.getActivity().getResources();
            InputStream in_s = res.openRawResource(context.getResourceId(name));

            byte[] b = new byte[in_s.available()];
            in_s.read(b);
            return b;
        } catch (Exception e) {
            Log.e(Extension.TAG,e.getLocalizedMessage());
            e.printStackTrace();
            return null;
        }
    }
}
