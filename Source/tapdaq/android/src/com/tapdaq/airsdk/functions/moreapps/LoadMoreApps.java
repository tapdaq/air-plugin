package com.tapdaq.airsdk.functions.moreapps;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.MoreAppsContext;
import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.airsdk.functions.BaseFunction;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.moreapps.TMMoreAppsConfig;


public class LoadMoreApps extends BaseFunction implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try {
            Tapdaq.getInstance().loadMoreApps(context.getActivity(), getConfig(args[0]), MoreAppsContext.getEventListener());
        } catch (Exception e) {
            Extension.log(e);
        }
        return null;
    }

    private TMMoreAppsConfig getConfig(FREObject as3Config) {
        TMMoreAppsConfig config = new TMMoreAppsConfig();

        config.setHeaderText(getStringProperty(as3Config, "headerText"));
        config.setHeaderTextColor(Utils.convertColor(getIntProperty(as3Config, "headerTextColor")));
        config.setHeaderColor(Utils.convertColor(getIntProperty(as3Config, "headerColor")));
        config.setHeaderCloseButtonColor(Utils.convertColor(getIntProperty(as3Config, "headerCloseButtonColor")));

        config.setBackgroundColor(Utils.convertColor(getIntProperty(as3Config, "backgroundColor")));
        config.setAppNameColor(Utils.convertColor(getIntProperty(as3Config, "appNameColor")));
        config.setAppButtonTextColor(Utils.convertColor(getIntProperty(as3Config, "appButtonTextColor")));
        config.setAppButtonColor(Utils.convertColor(getIntProperty(as3Config, "appButtonColor")));

        config.setInstalledButtonText(getStringProperty(as3Config, "installedButtonText"));
        config.setInstalledAppButtonTextColor(Utils.convertColor(getIntProperty(as3Config, "installedButtonTextColor")));
        config.setInstalledAppButtonColor(Utils.convertColor(getIntProperty(as3Config, "installedButtonColor")));

        return config;
    }
}
