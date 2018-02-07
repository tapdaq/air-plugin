package com.tapdaq.airsdk.functions.banner;

import android.view.Gravity;
import android.view.View;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.BannerContext;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.functions.BaseFunction;

public class ShowBanner extends BaseFunction implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            if (BannerContext.bannerAdView != null) {

                final String position = getStringFromFREObject(args[0]);
                context.getActivity().runOnUiThread(new Runnable() {
                    public void run() {
                        BannerContext.bannerAdView.setVisibility(View.VISIBLE);
                        if (!BannerContext.popupWindow.isShowing()) {
                            BannerContext.popupWindow.showAtLocation(
                                    context.getActivity().getWindow().getDecorView().getRootView(),
                                    getBannerGravityFromString(position), 0, 0);
                        }
                    }
                });

            } else {
                Extension.log("Banner isn't ready! Please try to load it first!");
            }
        }
        catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }

    private int getBannerGravityFromString(String position) {
        if(position.equalsIgnoreCase("top")) {
            return Gravity.TOP | Gravity.CENTER_HORIZONTAL;
        }
        return Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
    }
}
