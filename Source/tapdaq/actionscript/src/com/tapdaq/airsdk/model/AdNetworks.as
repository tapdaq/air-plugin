package com.tapdaq.airsdk.model {
public class AdNetworks {
    public static var UNKNOWN : int = -1;
    public static var AD_MOB : int = 0;
    public static var FACEBOOK : int = 1;
    public static var CHARTBOOST : int = 2;
    public static var ADCOLONY : int = 3;
    public static var APPLOVIN : int = 4;
    public static var UNITY_ADS : int = 5;
    public static var VUNGLE : int = 6;
    public static var TAPJOY : int = 7;
    public static var IRONSOURCE : int = 8;
    public static var INMOBI : int = 9;
    public static var HYPRMX : int = 10;

    public static var AD_MOB_NAME : String = "AdMob";
    public static var FACEBOOK_NAME : String = "Facebook";
    public static var CHARTBOOST_NAME : String = "Chartboost";
    public static var ADCOLONY_NAME: String = "AdColony";
    public static var APPLOVIN_NAME : String = "AppLovin";
    public static var UNITY_ADS_NAME : String = "UnityAds";
    public static var VUNGLE_NAME : String = "Vungle";
    public static var TAPJOY_NAME : String = "Tapjoy";
    public static var IRONSOURCE_NAME : String = "IronSource";
    public static var INMOBI_NAME : String = "InMobi";
    public static var HYPRMX_NAME : String = "HyprMX";

    public static function getNetworkFromName (name : String) : int {
        switch (name.toLowerCase()) {
            case AD_MOB_NAME.toLowerCase():
                return AD_MOB;
            case FACEBOOK_NAME.toLowerCase():
                return FACEBOOK;
            case CHARTBOOST_NAME.toLowerCase():
                return CHARTBOOST;
            case ADCOLONY_NAME.toLowerCase():
                return ADCOLONY;
            case APPLOVIN_NAME.toLowerCase():
                return APPLOVIN;
            case UNITY_ADS_NAME.toLowerCase():
                return UNITY_ADS;
            case VUNGLE_NAME.toLowerCase():
                return VUNGLE;
            case TAPJOY_NAME.toLowerCase():
                return TAPJOY;
            case IRONSOURCE_NAME.toLowerCase():
                return IRONSOURCE;
            case INMOBI_NAME.toLowerCase():
                return INMOBI;
            case HYPRMX_NAME.toLowerCase():
                return HYPRMX;
        }

        return UNKNOWN;
    }
}
}
