package com.tapdaq.airsdk.utils {
import com.tapdaq.airsdk.Tapdaq;
import com.tapdaq.airsdk.model.VOs.TapdaqAdError;
import com.tapdaq.airsdk.model.TapdaqNativeAd;
import com.tapdaq.airsdk.model.Placement;
import com.tapdaq.airsdk.model.VOs.TapdaqVerificationData;
import com.tapdaq.airsdk.model.enums.TapdaqCreativeType;

import flash.desktop.NativeApplication;

import flash.external.ExtensionContext;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.Dictionary;

public class Utils {

	public static function getVersionNumber () : String {
        var extensionFile = ExtensionContext.getExtensionDirectory("com.tapdaq.airsdk").resolvePath("META-INF/ANE/extension.xml");
        var fileStream:FileStream = new FileStream();
        fileStream.open(extensionFile, FileMode.READ);
        var xml : XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
        fileStream.close();
        var ns : Namespace = xml.namespace();
        return xml.ns::versionNumber;
	}

	public static function supportedPlacementToJSONString(supportedPlacementTags:Array):String {

		if(!supportedPlacementTags || supportedPlacementTags.length == 0)
			return "";

		var result:Object = [];
		for (var i:int = 0; i < supportedPlacementTags.length; i++) {
			var placement:Placement = supportedPlacementTags[i];
			result.push({tag:placement.placementTag, creativeTypes:creativeTypesToStringArray(placement.creativeTypes)});
		}
		return JSON.stringify(result);
	}

	public static function creativeTypesToStringArray(creativeTypes:Array):Array {

		var result:Array = [];
		for (var i:int = 0; i < creativeTypes.length; i++) {
			var creativeType:TapdaqCreativeType = creativeTypes[i];
			result.push(creativeType.value);
		}
		return result;
	}

	public static function creativeTypesToJSONString(creativeTypes:Array):String {

		if(!creativeTypes || creativeTypes.length == 0)
			return "";

		var result:Array = [];
		for (var i:int = 0; i < creativeTypes.length; i++) {
			var creativeType:TapdaqCreativeType = creativeTypes[i];
			result.push(creativeType.value);
		}
		return JSON.stringify(result);
	}

	public static function dictionaryToJSON(dictionary : Dictionary):String {

		if(!dictionary) return "";

		var result:Array = [];
		for (var key : *  in dictionary) {
			result.push({"key" : key.toString(), "value": dictionary[key]})
		}
		return JSON.stringify(result);
	}

	public static function packageAdErrorJSON(json:Object):TapdaqAdError {
		if(!json)
			return null;

		var result:TapdaqAdError = new TapdaqAdError(json.errorCode, json.errorMessage);
		return result;
	}

	public static function packageVerificationDataJSON(json:Object):TapdaqVerificationData {
		if(!json)
			return null;

		var result:TapdaqVerificationData = new TapdaqVerificationData(json.placementTag, json.rewardName, json.rewardAmount );
		return result;
	}

	public static function getDataFromString (string : String) : Dictionary {
        var data : Dictionary = new Dictionary();

        for each (var event : String in string.split(";")) {
            var split = event.split("=");
			if (split.length != 2 ) continue;
            data[split[0]] = split[1];
        }

		return data;
    }
}
}
