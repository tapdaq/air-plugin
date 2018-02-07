package com.tapdaq.airsdk.functions.banner;

import android.view.View;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.BannerContext;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.OfferwallContext;
import com.tapdaq.sdk.Tapdaq;


public class HideBanner implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            if(BannerContext.bannerAdView != null) {
                Tapdaq.getInstance().showOfferwall(context.getActivity(), OfferwallContext.getEventListener());
                context.getActivity().runOnUiThread(new Runnable() {
                    public void run() {
                        BannerContext.bannerAdView.setVisibility(View.GONE);
                        BannerContext.bannerAdView.destroy(context.getActivity());
                        BannerContext.bannerAdView = null;
                        BannerContext.popupWindow.dismiss();
                    }
                });
            } else {
                Extension.log("Banner isn't ready!");
            }
        }
        catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }
}
