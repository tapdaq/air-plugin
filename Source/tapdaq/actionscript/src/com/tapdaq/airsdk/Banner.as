package com.tapdaq.airsdk {
import com.tapdaq.airsdk.model.TapdaqEvent;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class Banner extends EventDispatcher {

    //
    // Banner sizes
    //
    public static const SIZE_STANDARD : String = "STANDARD";
    public static const SIZE_MEDIUM_RECT : String = "MEDIUM_RECT";
    public static const SIZE_LARGE : String = "LARGE";
    public static const SIZE_FULL : String = "FULL";
    public static const SIZE_LEADERBOARD : String = "LEADERBOARD";
    public static const SIZE_SMART : String = "SMART";

    //
    // Banner positions
    //
    public static const POSITION_TOP : String = "top";
    public static const POSITION_BOTTOM : String = "bottom";

    private static var _instance : Banner;
    public var extCtx:ExtensionContext = null;

    public function Banner() {
        if (!_instance) {
            extCtx = ExtensionContext.createExtensionContext("com.tapdaq.airsdk", "banner");
            if (extCtx != null) {
                extCtx.addEventListener(StatusEvent.STATUS, onStatus);
            } else {
                trace('[Tapdaq Air SDK] Error - Banner Extension Context is null.');
            }
            _instance = this;
        } else {
            throw Error( 'This is a singleton, use getInstance(), do not call the constructor directly.');
        }
    }

    public static function getInstance() : Banner {
        return _instance ? _instance : new Banner();
    }

    private function onStatus( event : StatusEvent ) : void {
        var e:TapdaqEvent = TapdaqEvent.EventFactory(event);
        if (e) dispatchEvent(e);
    }

    public function load( size : String = SIZE_STANDARD) : void {
        extCtx.call("load", size);
    }

    public function show(position : String = POSITION_TOP) : void {
        extCtx.call("show", position);
    }

    public function isAvailable() : Boolean {
        return extCtx.call("available");
    }

    public function hide() : Boolean {
        return extCtx.call("hide");
    }
}
}
