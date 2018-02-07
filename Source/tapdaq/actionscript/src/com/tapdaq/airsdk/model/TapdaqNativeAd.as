package com.tapdaq.airsdk.model {
import com.tapdaq.airsdk.Tapdaq;

public class TapdaqNativeAd  {

	public var applicationId:String;
    public var targetingId:String;
    public var subscriptionId:String;
    public var appName:String;
    public var description:String;
    public var buttonText:String;
    public var developerName:String;
    public var ageRating:String;
    public var appSize:String;
    public var averageReview:String;
    public var totalReviews:String;
    public var category:String;
    public var appVersion:String;
    public var price:String;
    public var iconUrl:String;
    public var imageUrl:String;
    public var uniqueId:String;
    public var placementTag:String;

    public static function fromJSON(json : String):TapdaqNativeAd {

        if (!json) return null;
        var jsonObject : Object = JSON.parse(json);
		if (!jsonObject) return null;

        var result:TapdaqNativeAd = new TapdaqNativeAd();

		result.appName = jsonObject.appName;
        result.description = jsonObject.description;
        result.applicationId = jsonObject.applicationId;
        result.targetingId = jsonObject.targetingId;
        result.developerName = jsonObject.developerName;
        result.ageRating = jsonObject.ageRating;
        result.appSize = jsonObject.appSize;
        result.averageReview = jsonObject.averageReview;
        result.totalReviews = jsonObject.totalReviews;
        result.category = jsonObject.category;
        result.appVersion = jsonObject.appVersion;
        result.price = jsonObject.price;
        result.subscriptionId = jsonObject.subscriptionId;
        result.imageUrl = jsonObject.imageUrl;
        result.iconUrl = jsonObject.iconUrl;
        result.buttonText = jsonObject.buttonText;
        result.uniqueId = jsonObject.uniqueId;
        result.placementTag = jsonObject.tag

		return result;
    }

    public function triggerClick():void {
        Tapdaq.context.call("AirTapdaqTriggerClick",uniqueId);
    }

    public function triggerDisplay():void {
        Tapdaq.context.call("AirTapdaqTriggerDisplay", uniqueId);
    }
}
}
