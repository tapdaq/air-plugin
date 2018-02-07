package com.tapdaq.airsdk.utils {
import flash.system.Capabilities;

public class AppUtils {
    public static function isIosDevice() : Boolean {
        return Capabilities.os.search("iPhone")!=-1 || Capabilities.os.search("iPad")!=-1 || Capabilities.version.indexOf("IOS") == 0;
    }

    public static function isAndroidDevice() : Boolean {
        return Capabilities.os.search("Android")!=-1 || Capabilities.manufacturer.search("Android")!=-1 || Capabilities.version.indexOf("AND")==0;
    }

}
}
