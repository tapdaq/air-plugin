package com.tapdaq.airsdk.model
{
import com.tapdaq.airsdk.utils.Utils;

import flash.events.StatusEvent;

public class TapdaqEvent extends StatusEvent {

    public static const DID_INITIALIZE:String = "AirTapdaqEvent_onDidInitialize";

    public static const DID_LOAD:String = "load";
    public static const DID_FAIL_LOAD:String = "failload";


    public static const DID_CLOSE:String = "close";
    public static const DID_SHOW:String = "show";

    public static const DID_CUSTOM:String = "custom";
    public static const DID_REFRESH:String = "refresh";

    public static const DID_CLICK:String = "click";
    public static const DID_HIDE:String = "hide";

    public var data : *;

    public function TapdaqEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, code:String = "", level:String = "") {
        super(type, bubbles, cancelable, code, level);
    }

    public static function EventFactory( event : StatusEvent ) : TapdaqEvent {
        var e : TapdaqEvent = new TapdaqEvent(event.code, event.bubbles, event.cancelable, event.level);

        trace(event.level);

        switch (event.code) {
            case TapdaqEvent.DID_LOAD:
                trace("[Tapdaq Air SDK] Ad loaded");
                break;
            case TapdaqEvent.DID_FAIL_LOAD:
                trace("[Tapdaq Air SDK] Ad failed to load with error : " + event.level);
                break;
            case TapdaqEvent.DID_SHOW:
                trace("[Tapdaq Air SDK] Ad shown");
                break;
            case TapdaqEvent.DID_CLICK:
                trace("[Tapdaq Air SDK] Ad clicked");
                break;
            case TapdaqEvent.DID_HIDE:
                trace("[Tapdaq Air SDK] Ad hidden");
                break;

            case TapdaqEvent.DID_CLOSE:
                trace("[Tapdaq Air SDK] Ad closed");
                break;

            case TapdaqEvent.DID_REFRESH:
                trace("[Tapdaq Air SDK] Ad refreshed");
                break;

            case TapdaqEvent.DID_CUSTOM:
                trace("[Tapdaq Air SDK] Custom Event");
                var customEventData : String = event.level as String;
                e.data = Utils.getDataFromString(customEventData);
                break;

            case "LOGGING":
                trace('[Tapdaq Air SDK] >> ' + event.level);
        }

        return e;
    }
}
}