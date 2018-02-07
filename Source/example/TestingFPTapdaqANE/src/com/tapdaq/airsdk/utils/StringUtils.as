package com.tapdaq.airsdk.utils {
import flash.utils.Dictionary;
import flash.utils.describeType;

public class StringUtils {

    public static function getDictionaryAsString ( dict : Dictionary ) : String {
        var result : String = "";
        for(var key:* in dict) {
            result += key + " = " + dict[key] + ";";
        }

        return result;
    }

    public static function getObjectAsString( obj : Object, delimiter : String = "\n"):String {
        if (!obj) return "";

        var sourceInfo = describeType(obj);
        var prop:XML;
        var ret: Array = [];


        for each(prop in sourceInfo.variable) {
            ret.push(prop.@name +" = " + obj[prop.@name])
        }

        for each(prop in sourceInfo.accessor) {
            if(prop.@access == "readwrite") {
                ret.push(prop.@name + " = " + obj[prop.@name])
            }
        }

        return ret.join(delimiter);
    }

}

}
