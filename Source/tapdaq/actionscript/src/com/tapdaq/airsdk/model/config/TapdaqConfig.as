package com.tapdaq.airsdk.model.config {
import flash.utils.Dictionary;

public class TapdaqConfig {

    private var _testDevices : Dictionary = null;

    public function TapdaqConfig(applicationId:String, clientKey:String) {

        _applicationId  = applicationId;
        _clientKey      = clientKey;
    }

    public function get testDevices () : Dictionary {
        if (!_testDevices) _testDevices = new Dictionary();
        return _testDevices;
     }

    public function setTestDevicesForNetwork(networkId : int, devices : Array ) : void {
        testDevices[networkId] = devices;
    }

    /**
     * Use this method for specifying the creative type support. Will default to only containing
     * AirTapdaqCreativeType.INTERSTITIAL_LANDSCAPE and AirTapdaqCreativeType.INTERSTITIAL_PORTRAIT if not provided. That
     * means that the app will fetch ads for only interstitials.
     *
     * @param supportedPlacementTags the desired creative types to support
     * @return the current config object
     */
    public function withPlacementTagSupport(supportedPlacementTags:Array):TapdaqConfig {
        _supportedPlacementTags = supportedPlacementTags;
        return this;
    }

    /**
     * Use this method for specifying the creative type support. Will default to only containing
     * AirTapdaqCreativeType.INTERSTITIAL_LANDSCAPE and AirTapdaqCreativeType.INTERSTITIAL_PORTRAIT if not provided. That
     * means that the app will fetch ads for only interstitials.
     *
     * @param supportedCreativeTypes the desired creative types to support
     * @return the current config object
     */
    public function withCreativeTypesSupport(supportedCreativeTypes:Array):TapdaqConfig {
        _supportedCreativeTypes = supportedCreativeTypes;
        return this;
    }

    /**
     * Use this method for specifying the max number of images a device will cache for each creative type. Will default
     * to {@code 3} if not provided.
     *
     * @param maxNumberOfCachedAdverts the desired max number for caching
     * @return the current config object
     */
    public function withMaxNumberOfCachedAdverts(maxNumberOfCachedAdverts:int):TapdaqConfig {
        _maxNumberOfCachedAdverts = maxNumberOfCachedAdverts;
        return this;
    }


	/**
     * Use this method to enable logs
     * @param value
     */
    public function set debugMode(value:Boolean):void{
            _debugMode = value;
    }

    public function get debugMode():Boolean{
            return _debugMode;
    }

    /***************************
     *
     * PRIVATE
     *
     ***************************/

    private var _applicationId                  : String        = null;
    private var _clientKey                      : String        = null;
    private var _maxNumberOfCachedAdverts       : int           = 3;
    private var _supportedPlacementTags         : Array         = null;
    private var _supportedCreativeTypes         : Array         = null;

    private var _debugMode                       : Boolean       = false;

    public function get applicationId():String {
        return _applicationId;
    }

    public function get clientKey():String {
        return _clientKey;
    }

    public function get supportedPlacements():Array {
        return _supportedPlacementTags ? _supportedPlacementTags.slice() : null;
    }

    public function get supportedCreativeTypes():Array {
        return _supportedCreativeTypes ? _supportedCreativeTypes.slice() : null;
    }

    public function get maxNumberOfCachedAdverts():int {
        return _maxNumberOfCachedAdverts;
    }
}
}
