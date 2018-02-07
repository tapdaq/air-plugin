package com.tapdaq.airsdk.utils;

import android.graphics.Color;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREObject;
import com.tapdaq.sdk.CreativeType;
import com.tapdaq.sdk.TMBannerAdView;
import com.tapdaq.sdk.TMNativeAd;
import com.tapdaq.sdk.ads.TapdaqPlacement;
import com.tapdaq.sdk.common.TMAdError;
import com.tapdaq.sdk.common.TMAdType;
import com.tapdaq.sdk.common.TMBannerAdSizes;
import com.tapdaq.sdk.model.TMAdSize;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Utils {

    public static String mapToString(Map<Object, Object> map){
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<Object,Object> entry : map.entrySet()) {
            sb.append(entry.getKey() + "=" + entry.getValue() + ";");
        }

        return sb.toString();
    }


    public static String[] FREArrayToArray(FREArray freArray) throws Exception
    {
        String[] result = new String[(int)freArray.getLength()];
        for (int i = 0; i < freArray.getLength(); i++)
        {
            FREObject object = freArray.getObjectAt(i);
            String string = object.getAsString();
            result[i] = string;
        }

        return  result;
    }

    public static TapdaqPlacement[] parseSupportedPlacements(String placementsJSONString)
    {
        TapdaqPlacement[] result;
        try
        {
            JSONArray json = new JSONArray(placementsJSONString);
            result = new TapdaqPlacement[json.length()];

            for(int i = 0; i < json.length(); i++)
            {
                JSONObject placementObject = json.getJSONObject(i);
                String placementTag = placementObject.getString("tag");
                CreativeType[] creativeTypes = parseCreativeTypeStringArray(jsonArrayToStringArray((JSONArray) placementObject.get("creativeTypes")));
                TapdaqPlacement placement = TapdaqPlacement.createPlacement(Arrays.asList(creativeTypes), placementTag);
                result[i] = placement;
            }

            return result;
        }
        catch (Exception e)
        {
            return null;
        }

    }

    public static CreativeType[] parseCreativeTypes(String creativeTypesJSON)
    {
        CreativeType[] result;
        try
        {
            JSONArray json = new JSONArray(creativeTypesJSON);
            result = new CreativeType[json.length()];

            int nullValues = 0;

            for(int i = 0; i < json.length(); i++)
            {
                String creativeTypeRaw = json.getString(i);
                CreativeType creativeType = parseCreativeTypeString(creativeTypeRaw);
                if(creativeType == null)
                {
                    nullValues = nullValues + 1;
                }

                result[i] = creativeType;
            }

            // result without null values (because android version doesnt support ad type none)
            if(nullValues == 0)
            {
                return result;
            }
            else
            {
                // repackage without null values
                CreativeType[] adjustedResult = new CreativeType[json.length() - nullValues];
                int index = 0;
                for (CreativeType aResult : result) {
                    if (aResult != null) {
                        adjustedResult[index] = aResult;
                        index = index + 1;
                    }
                }

                return  adjustedResult;

            }


        }
        catch (Exception e)
        {
            return null;
        }
    }

    private static CreativeType[] parseCreativeTypeStringArray(String[] types)
    {
        CreativeType[] result = new CreativeType[types.length];
        for (int i = 0; i < types.length; i++) {
            String type = types[i];
            result[i] = parseCreativeTypeString(type);
        }
        return result;
    }

    public static String[] jsonArrayToStringArray(JSONArray array) {
        if(array==null)
            return null;

        String[] arr=new String[array.length()];
        for(int i=0; i<arr.length; i++) {
            arr[i]=array.optString(i);
        }
        return arr;
    }

    public static String parseTMAdError(TMAdError adError)
    {
        try
        {
            JSONObject errorDataObject = new JSONObject();
            errorDataObject.put("errorCode", adError.getErrorCode());
            errorDataObject.put("errorMessage", adError.getErrorMessage());
            return errorDataObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }

    public static String parseAdEventData(int adType, String placementTag, TMAdError adError)
    {
        try
        {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("adType", TMAdType.getString(adType));
            jsonObject.put("placementTag", placementTag);

            if (adError != null)
            {
                JSONObject errorDataObject = new JSONObject();
                errorDataObject.put("errorCode", adError.getErrorCode());
                errorDataObject.put("errorMessage", adError.getErrorMessage());
                jsonObject.put("error", errorDataObject);
            }

            return jsonObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }

    public static String parseNativeAdEventData(int adType, String nativeAdType, String placementTag, TMAdError adError)
    {
        try
        {

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("adType", TMAdType.getString(adType));
            jsonObject.put("nativeAdType", nativeAdType);
            jsonObject.put("placementTag", placementTag);

            if (adError != null)
            {
                JSONObject errorDataObject = new JSONObject();
                errorDataObject.put("errorCode", adError.getErrorCode());
                errorDataObject.put("errorMessage", adError.getErrorMessage());
                jsonObject.put("error", errorDataObject);
            }

            return jsonObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }

    public static String parseAdVerifyData(int adType, String placementTag, String reward, Double amount)
    {
        try
        {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("adType", TMAdType.getString(adType));
            jsonObject.put("placementTag", placementTag);
            jsonObject.put("rewardName", reward);
            jsonObject.put("rewardAmount", amount);

            return jsonObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }

    public static String parseAdAvailabilityEventData(int adType)
    {
        try
        {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("adType", TMAdType.getString(adType));
            jsonObject.put("placementTag", "");

            return jsonObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }


//    public static TMAdapter parseAdapterString(String adapter)
//    {
//        if(adapter.equals("ad_mob"))
//        {
//            return Extension.adMobAdapter;
//        }
//        else if(adapter.equals("facebook"))
//        {
//            return Extension.facebookAdapter;
//        }
//        else if(adapter.equals("vungle"))
//        {
//            return Extension.vungleAdapter;
//        }
//        else if(adapter.equals("unity_ads"))
//        {
//            return Extension.unityAdsAdapter;
//        }
//        else if(adapter.equals("ad_colony"))
//        {
//            return Extension.adColonyAdapter;
//        }
//        else if(adapter.equals("chartboost"))
//        {
//            return Extension.chartboostAdapter;
//        }
//        else if(adapter.equals("app_lovin"))
//        {
//            return Extension.appLovinAdapter;
//        }
//        else if(adapter.equals("tapjoy"))
//        {
//            return Extension.tapjoyAdapter;
//        }
//
//        return null;
//    }

    public static CreativeType parseCreativeTypeString(String type)
    {
        if ( type.equals("BANNER") )
        {
            return CreativeType.BANNER;
        }
        else if( type.equals("INTERSTITIAL_LANDSCAPE") )
        {
            return CreativeType.INTERSTITIAL_LANDSCAPE;
        }
        else if( type.equals("INTERSTITIAL_PORTRAIT") )
        {
            return CreativeType.INTERSTITIAL_PORTRAIT;
        }
        else if( type.equals("VIDEO_INTERSTITIAL") )
        {
            return CreativeType.VIDEO_INTERSTITIAL;
        }
        else if( type.equals("REWARDED_VIDEO_INTERSTITIAL") )
        {
            return CreativeType.REWARDED_VIDEO_INTERSTITIAL;
        }
        else if( type.equals("SQUARE_SMALL") )
        {
            return CreativeType.SQUARE_SMALL;
        }
        else if( type.equals("SQUARE_MEDIUM") )
        {
            return CreativeType.SQUARE_MEDIUM;
        }
        else if( type.equals("SQUARE_LARGE") )
        {
            return CreativeType.SQUARE_LARGE;
        }
        else if( type.equals("NEWSFEED_TALL_SMALL") )
        {
            return CreativeType.NEWSFEED_TALL_SMALL;
        }
        else if( type.equals("NEWSFEED_TALL_MEDIUM") )
        {
            return CreativeType.NEWSFEED_TALL_MEDIUM;
        }
        else if( type.equals("NEWSFEED_TALL_LARGE") )
        {
            return CreativeType.NEWSFEED_TALL_LARGE;
        }
        else if( type.equals("NEWSFEED_WIDE_SMALL") )
        {
            return CreativeType.NEWSFEED_WIDE_SMALL;
        }
        else if( type.equals("NEWSFEED_WIDE_MEDIUM") )
        {
            return CreativeType.NEWSFEED_WIDE_MEDIUM;
        }
        else if( type.equals("NEWSFEED_WIDE_LARGE") )
        {
            return CreativeType.NEWSFEED_WIDE_LARGE;
        }
        else if( type.equals("FULLSCREEN_TALL_SMALL") )
        {
            return CreativeType.FULLSCREEN_TALL_SMALL;
        }
        else if( type.equals("FULLSCREEN_TALL_MEDIUM") )
        {
            return CreativeType.FULLSCREEN_TALL_MEDIUM;
        }
        else if( type.equals("FULLSCREEN_TALL_LARGE") )
        {
            return CreativeType.FULLSCREEN_TALL_LARGE;
        }
        else if( type.equals("FULLSCREEN_WIDE_SMALL") )
        {
            return CreativeType.FULLSCREEN_WIDE_SMALL;
        }
        else if( type.equals("FULLSCREEN_WIDE_MEDIUM") )
        {
            return CreativeType.FULLSCREEN_WIDE_MEDIUM;
        }
        else if( type.equals("FULLSCREEN_WIDE_LARGE") )
        {
            return CreativeType.FULLSCREEN_WIDE_LARGE;
        }
        else if( type.equals("STRIP_TALL_SMALL") )
        {
            return CreativeType.STRIP_TALL_SMALL;
        }
        else if( type.equals("STRIP_TALL_MEDIUM") )
        {
            return CreativeType.STRIP_TALL_MEDIUM;
        }
        else if( type.equals("STRIP_TALL_LARGE") )
        {
            return CreativeType.STRIP_TALL_LARGE;
        }
        else if( type.equals("STRIP_WIDE_SMALL") )
        {
            return CreativeType.STRIP_WIDE_SMALL;
        }
        else if( type.equals("STRIP_WIDE_MEDIUM") )
        {
            return CreativeType.STRIP_WIDE_MEDIUM;
        }
        else if( type.equals("STRIP_WIDE_LARGE") )
        {
            return CreativeType.STRIP_WIDE_LARGE;
        }
        else
        {

            return null;
        }

    }


    // FIXME: there is no public tag in Ad object so require to pass it
    public static String parseNativeAd(TMNativeAd nativeAd, String tag, String uniqueId)
    {
        try
        {
            JSONObject nativeAdDataObject = new JSONObject();
            nativeAdDataObject.put("ageRating", nativeAd.getAgeRating());
            nativeAdDataObject.put("appName", nativeAd.getAppName());
            nativeAdDataObject.put("appSize", nativeAd.getAppSize());
            nativeAdDataObject.put("appVersion", nativeAd.getAppVersion());
            nativeAdDataObject.put("averageReview", nativeAd.getAverageReview());
            nativeAdDataObject.put("callToActionText", nativeAd.getCallToActionText());
            nativeAdDataObject.put("category", nativeAd.getCategory());
            nativeAdDataObject.put("currency", nativeAd.getCurrency());
            nativeAdDataObject.put("description", nativeAd.getDescription());
            nativeAdDataObject.put("developerName", nativeAd.getDeveloperName());
            nativeAdDataObject.put("iconUrl", nativeAd.getIconUrl());
            nativeAdDataObject.put("imageUrl", nativeAd.getImageUrl());
            nativeAdDataObject.put("price", nativeAd.getPrice());
            nativeAdDataObject.put("title", nativeAd.getTitle());
            nativeAdDataObject.put("totalReviews", nativeAd.getTotalReviews());
            nativeAdDataObject.put("uniqueId", uniqueId);
            nativeAdDataObject.put("tag", tag);
            return nativeAdDataObject.toString();
        }
        catch (Exception e)
        {
            return "";
        }
    }


    public static int convertColor(int color) {
        return 0xff000000 + color;
    }

}
