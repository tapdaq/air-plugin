package com.tapdaq.airsdk {
import com.tapdaq.airsdk.model.config.MoreAppsConfig;
import com.tapdaq.airsdk.model.TapdaqEvent;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class MoreApps extends EventDispatcher {
    private static var _instance : MoreApps;
    public var extCtx:ExtensionContext = null;

    public function MoreApps() {
        if (!_instance) {
            extCtx = ExtensionContext.createExtensionContext("com.tapdaq.airsdk", "moreapps");
            if (extCtx != null) {
                extCtx.addEventListener(StatusEvent.STATUS, onStatus);
            } else {
                trace('[Tapdaq Air SDK] Error - MoreApps Extension Context is null.');
            }
            _instance = this;

        } else {
            throw Error( 'This is a singleton, use getInstance(), do not call the constructor directly.');
        }
    }

    public static function getInstance() : MoreApps {
        return _instance ? _instance : new MoreApps();
    }

    private function onStatus( event : StatusEvent ) : void {
        var e:TapdaqEvent = TapdaqEvent.EventFactory(event);
        if (e) dispatchEvent(e);
    }

    public function load (config : MoreAppsConfig = null) : void {
        if (!config) config = new MoreAppsConfig();
        extCtx.call ("load", config);
    }

    public function show() : void {
        extCtx.call("show");
    }

    public function isAvailable() : Boolean {
        return extCtx.call("available");
    }


}

}

