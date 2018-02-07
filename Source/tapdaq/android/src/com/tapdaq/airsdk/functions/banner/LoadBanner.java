package com.tapdaq.airsdk.functions.banner;

import android.view.View;
import android.view.WindowManager;
import android.widget.PopupWindow;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.BannerContext;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.functions.BaseFunction;
import com.tapdaq.sdk.TMBannerAdView;
import com.tapdaq.sdk.common.TMBannerAdSizes;
import com.tapdaq.sdk.helpers.TMDevice;
import com.tapdaq.sdk.model.TMAdSize;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;


public class LoadBanner extends BaseFunction implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            String bannerType = getStringFromFREObject(args[0]);

            Extension.log("Loading banner type : " + bannerType);

            TMAdSize bannerAdSize = getBannerSizeFromString(bannerType);
            if (BannerContext.bannerAdView == null) {
                BannerContext.bannerAdView = new TMBannerAdView(context.getActivity());
                CreatePopupWindow(context, BannerContext.bannerAdView, bannerAdSize);
            }

            BannerContext.bannerAdView.load(context.getActivity(), bannerAdSize, BannerContext.getEventListener());
        } catch (Exception e) {
            Extension.log(e);
        }

        return null;
    }

    //TODO do we need this function for any other functionality in SDK? move to some helper if so
    private static void CreatePopupWindow(FREContext context, View view, TMAdSize size) {
        float scale = TMDevice.getDeviceScaleAsFloat(context.getActivity());
        float width = TMDevice.getWidth(context.getActivity());

        Extension.log("Creating PopupWindow with size : : " + size.width + "," + size.height + " and scale = " + scale + " and width = " + width);

        float intWidth = size.width == 0 ? width : size.width * scale;
        BannerContext.popupWindow = new PopupWindow(view, (int)intWidth, (int)(size.height * scale));

        // Copy system UI visibility flags set on Unity player window to newly created PopUpWindow.
        int visibilityFlags = context.getActivity().getWindow().getAttributes().flags;
        BannerContext.popupWindow .getContentView().setSystemUiVisibility(visibilityFlags);

        // Workaround to prevent ad views from losing visibility on activity changes for certain
        // devices (eg. Huawei devices).

        setPopUpWindowLayoutType(BannerContext.popupWindow, WindowManager.LayoutParams.TYPE_APPLICATION_SUB_PANEL);
    }

    public static void setPopUpWindowLayoutType(PopupWindow popupWindow, int layoutType) {
        try {
            Method method = PopupWindow.class.getDeclaredMethod("setWindowLayoutType", int.class);
            method.setAccessible(true);
            method.invoke(popupWindow, layoutType);
        } catch (NoSuchMethodException exception) {
            Extension.log(String.format("Unable to set popUpWindow window layout type: %s", exception.getLocalizedMessage()));
        } catch (IllegalAccessException exception) {
            Extension.log(String.format("Unable to set popUpWindow window layout type: %s", exception.getLocalizedMessage()));
        } catch (InvocationTargetException exception) {
            Extension.log(String.format("Unable to set popUpWindow window layout type: %s", exception.getLocalizedMessage()));
        }
    }

    private TMAdSize getBannerSizeFromString(String bannerSize) {
        TMAdSize bannerAdSize = TMBannerAdSizes.STANDARD;

        if(bannerSize.equalsIgnoreCase("STANDARD")) {
            bannerAdSize = TMBannerAdSizes.STANDARD;
        } else if(bannerSize.equalsIgnoreCase("LARGE")) {
            bannerAdSize = TMBannerAdSizes.LARGE;
        } else if(bannerSize.equalsIgnoreCase("MEDIUM_RECT")) {
            bannerAdSize = TMBannerAdSizes.MEDIUM_RECT;
        } else if(bannerSize.equalsIgnoreCase("FULL")) {
            bannerAdSize = TMBannerAdSizes.FULL;
        } else if(bannerSize.equalsIgnoreCase("LEADERBOARD")) {
            bannerAdSize = TMBannerAdSizes.LEADERBOARD;
        } else if(bannerSize.equalsIgnoreCase("SMART")) {
            bannerAdSize = TMBannerAdSizes.SMART;
        }

        return bannerAdSize;
    }

}
