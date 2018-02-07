package com.tapdaq.airsdk {
import com.tapdaq.airsdk.model.TapdaqEvent;
import com.tapdaq.airsdk.utils.Utils;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class Offerwall extends EventDispatcher {
    private static var _instance : Offerwall;
    public var extCtx:ExtensionContext = null;

    public function Offerwall() {
        if (!_instance) {
            extCtx = ExtensionContext.createExtensionContext("com.tapdaq.airsdk", "offerwall");
            if (extCtx != null) {
                extCtx.addEventListener(StatusEvent.STATUS, onStatus);
            } else {
                trace('[Tapdaq Air SDK] Error - Offerwall Extension Context is null.');
            }
            _instance = this;
        } else {
            throw Error( 'This is a singleton, use getInstance(), do not call the constructor directly.');
        }
    }

    public static function getInstance() : Offerwall {
        return _instance ? _instance : new Offerwall();
    }

    private function onStatus( event : StatusEvent ) : void {
        var e:TapdaqEvent = TapdaqEvent.EventFactory(event);
        if (e) dispatchEvent(e);
    }

    public function load() : void {
        extCtx.call("load");
    }

    public function show() : void {
        extCtx.call("show");
    }

    public function isAvailable() : Boolean {
        return extCtx.call("available");
    }
}
}
