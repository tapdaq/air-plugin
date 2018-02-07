package com.tapdaq.airsdk {

import com.tapdaq.airsdk.model.PlacementTag;
import com.tapdaq.airsdk.model.TapdaqEvent;
import com.tapdaq.airsdk.model.TapdaqNativeAd;
import com.tapdaq.airsdk.model.VOs.TapdaqAdError;
import com.tapdaq.airsdk.model.config.TapdaqConfig;
import com.tapdaq.airsdk.model.enums.TapdaqAdType;
import com.tapdaq.airsdk.model.enums.TapdaqCreativeType;
import com.tapdaq.airsdk.model.events.TapdaqAdEvent;
import com.tapdaq.airsdk.model.events.TapdaqNativeAdDataEvent;
import com.tapdaq.airsdk.model.events.TapdaqNativeAdEvent;
import com.tapdaq.airsdk.model.events.TapdaqVerifyAdEvent;
import com.tapdaq.airsdk.utils.Utils;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;

public class Tapdaq extends EventDispatcher {



        public static function get isSupported():Boolean {

            var supported:Boolean = _isIOS() || _isAndroid();

            if (!supported)
                _log("Tapdaq ANE is not supported on this platform");

            return supported;
        }

        /**
         * Init tapdaq
         * @param applicationId
         * @param clientKey
         * @return tapdaq instance
         */
        public static function init(config:TapdaqConfig):Tapdaq {

            if (!isSupported)
                return null;

            if (!_instance)
                new Tapdaq(Private, config);

            return _instance;
        }



        public function loadInterstitial(adType:TapdaqAdType, tag : String = PlacementTag.DEFAULT):void {

            if (!isSupported)
                return;

            if (adType != TapdaqAdType.STATIC_INTERSTITIAL && adType != TapdaqAdType.VIDEO_INTERSTITIAL && adType != TapdaqAdType.REWARD_INTERSTITIAL)
                throw  new Error("Invalid ad type! Allowed values : AirTapdaqAdType.STATIC_INTERSTITIAL, AirTapdaqAdType.VIDEO_INTERSTITIAL, AirTapdaqAdType.REWARD_INTERSTITIAL");

            context.call("AirTapdaqLoadInterstitial", tag ? tag : "", adType.value);
        }

        /**
         * Display interstitial ad (static, video or rewarded video)
         * @param adType - allowed values : AirTapdaqAdType.STATIC_INTERSTITIAL, AirTapdaqAdType.VIDEO_INTERSTITIAL, AirTapdaqAdType.REWARD_INTERSTITIAL
         * @param placementTag - "default" is none passed
         */
        public function showInterstitial(adType:TapdaqAdType, tag : String = PlacementTag.DEFAULT):void {

            if (!isSupported)
                return;

            if (adType != TapdaqAdType.STATIC_INTERSTITIAL && adType != TapdaqAdType.VIDEO_INTERSTITIAL && adType != TapdaqAdType.REWARD_INTERSTITIAL)
                throw  new Error("Invalid ad type! Allowed values : AirTapdaqAdType.STATIC_INTERSTITIAL, AirTapdaqAdType.VIDEO_INTERSTITIAL, AirTapdaqAdType.REWARD_INTERSTITIAL");

            context.call("AirTapdaqShowInterstitial", tag, adType.value);
        }




        /**
         * Load native Ad
         * @param creativeType
         * @param tag
         */
        public function loadNativeAd(creativeType:TapdaqCreativeType, tag : String):void {

            if (!isSupported)
                return;

            context.call("AirTapdaqLoadNativeAd", creativeType.value, tag);
        }

        /**
         * Get native Ad data
         * @param creativeType
         * @param placementTag
         */
        public function getNativeAd(creativeType:TapdaqCreativeType, tag : String):void {

            if (!isSupported)
                return;

            context.call("AirTapdaqGetNativeAd", creativeType.value, tag);
        }

        /**
         * Opens debugger view
         */
        public function startDebugger():void {

            if (!isSupported)
                return;

            context.call("AirTapdaqStartTestActivity");
        }

        /***************************
         *
         * PRIVATE
         *
         ***************************/


        private static var _instance : Tapdaq = null;

        public static var context : ExtensionContext = null;

        private var _config:TapdaqConfig;

        public function Tapdaq(access:Class, config:TapdaqConfig) {

            if (access != Private)
                throw new Error("Private constructor call!");

            context = ExtensionContext.createExtensionContext("com.tapdaq.airsdk", "tapdaq");
            if (!context) {

                _log("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
                return;
            }

            //we should init it if possible
            //to setup all needed stuff
            try {
                var tapjoyExtContent = ExtensionContext.createExtensionContext("com.tapdaq.airsdk.tapjoy",null);
                if (!tapjoyExtContent) {
                    _log("Tapjoy ANE isn't present on the platform!!!");
                }else {
                    _log("Tapjoy ANE found on the platform! Initializing it....");
                    tapjoyExtContent.call("Init");
                }

            }catch (e:Error) {
                _log("Tapjoy ANE isn't present on the platform!!!");
            }

           this._config = config;

            context.addEventListener(StatusEvent.STATUS, _onStatus);

            var versionNumber : String =  Utils.getVersionNumber();

            context.call("AirTapdaqInit",
                    this._config.applicationId,
                    this._config.clientKey,
                    this._config.maxNumberOfCachedAdverts,
                    Utils.supportedPlacementToJSONString(this._config.supportedPlacements),
                    Utils.creativeTypesToJSONString(this._config.supportedCreativeTypes),
                    Utils.dictionaryToJSON(this._config.testDevices),
                    versionNumber,
                    this._config.debugMode
            );
            _instance = this;
        }

        private static function _isIOS():Boolean {
            return Capabilities.manufacturer.indexOf("iOS") > -1 && Capabilities.os.indexOf("x86") == -1;
        }

        private static function _isAndroid():Boolean {
            return Capabilities.manufacturer.indexOf("Android") > -1;
        }

        private static function _log(message:String):void {
            trace("AirTapdaq", message);
        }

        private function _onStatus(event:StatusEvent):void {

            trace(event.level);

            if (event.code == "LOGGING")
                _log(event.level);
            else {

                var adEventData:Object;
                var adType:TapdaqAdType;
                var error:TapdaqAdError;
                var placementTag : String;

                if (event.code == TapdaqEvent.DID_INITIALIZE) {
                    this.dispatchEvent(new TapdaqEvent(TapdaqEvent.DID_INITIALIZE));
                }
                else if (
                event.code == TapdaqAdEvent.AD_LOADED ||
                event.code == TapdaqAdEvent.WILL_DISPLAY ||
                event.code == TapdaqAdEvent.DID_DISPLAY ||
                event.code == TapdaqAdEvent.DID_CLICK ||
                event.code == TapdaqAdEvent.DID_CLOSE ||
                event.code == TapdaqAdEvent.DID_FAIL_TO_LOAD ||
                event.code == TapdaqAdEvent.DID_COMPLETE ||
                event.code == TapdaqAdEvent.DID_ENGAGEMENT ||
                event.code == TapdaqAdEvent.DID_REWARD_FAIL ||
                event.code == TapdaqAdEvent.ON_USER_DECLINED ||
                event.code == TapdaqAdEvent.DID_VERIFY ||
                event.code == TapdaqAdEvent.NOT_AVAILABLE
                )
                {

                    adEventData = JSON.parse(event.level);

                    adType = TapdaqAdType.fromValue(adEventData.adType);
                    placementTag = adEventData.placementTag;

                    if(event.code == TapdaqAdEvent.DID_REWARD_FAIL || event.code == TapdaqAdEvent.DID_FAIL_TO_LOAD)
                        error = Utils.packageAdErrorJSON(adEventData.error);

                    if(adType == TapdaqAdType.NATIVE)
                    {
                        var creativeType:TapdaqCreativeType = TapdaqCreativeType.fromValue(adEventData.nativeAdType);
                        this.dispatchEvent(new TapdaqNativeAdEvent(event.code, creativeType, placementTag, error));
                    }
                    else if (event.code == TapdaqAdEvent.DID_VERIFY)
                    {
                        this.dispatchEvent(new TapdaqVerifyAdEvent(event.code, adType, placementTag, adEventData.rewardName, adEventData.rewardAmount, error));
                    }
                    else
                    {
                        this.dispatchEvent(new TapdaqAdEvent(event.code, adType, placementTag, error));
                    }

                }
                else if ( event.code == TapdaqNativeAdDataEvent.AD_DATA )  {
                    var nativeAd:TapdaqNativeAd = TapdaqNativeAd.fromJSON(event.level)
                    this.dispatchEvent(new TapdaqNativeAdDataEvent(event.code, nativeAd));
                }

            }
        }

    }
}

final class Private{}