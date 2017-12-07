package com.tapdaq.airsdk.views {
import com.tapdaq.airsdk.Banner;
import com.tapdaq.airsdk.MoreApps;
import com.tapdaq.airsdk.Offerwall;
import com.tapdaq.airsdk.model.TapdaqEvent;
import com.tapdaq.airsdk.utils.StringUtils;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ScrollBarDisplayMode;
import feathers.controls.ScrollContainer;
import feathers.controls.TextArea;
import feathers.data.ArrayCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalAlign;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;

import starling.events.Event;
import starling.text.TextFormat;

public class UIView extends PanelScreen {

	/**
	 * ACTION IDs
	 */
	public static const INIT:String = "init";
	public static const LOAD_INTERSTITIAL:String = "loadInterstitial";
	public static const SHOW_INTERSTITIAL:String = "showInterstitial";
	public static const LOAD_VIDEO_INTERSTITIAL:String = "loadVideoInterstitial";
	public static const SHOW_VIDEO_INTERSTITIAL:String = "showVideoInterstitial";
	public static const LOAD_REWARDED_VIDEO_INTERSTITIAL:String = "loadRewardedVideoInterstitial";
	public static const SHOW_REWARDED_VIDEO_INTERSTITIAL:String = "showRewardedVideoInterstitial";


    public static const EVENT_SHOW_BANNER:String = "showBanner";
    public static const EVENT_IS_BANNER_AVAILABLE:String = "isBannerAvailable";
	public static const EVENT_LOAD_BANNER:String = "loadBanner";
    public static const EVENT_DESTROY_BANNER:String = "destroyBanner";

	public static const LOAD_NATIVE_AD:String = "loadNativeAd";
	public static const GET_NATIVE_AD:String = "getNativeAd";
	public static const START_DEBUGGER:String = "startDebugger";

    public static const EVENT_LOAD_OFFERWALL:String = "LoadOfferwall";
    public static const EVENT_IS_OFFERWALL_AVAILABLE:String = "IsOfferwallAvailable";
    public static const EVENT_SHOW_OFFERWALL:String = "ShowOfferwall";

    public static const EVENT_LOAD_MOREAPPS:String = "LoadMoreApps";
    public static const EVENT_IS_MOREAPPS_AVAILABLE:String = "IsMoreAppsAvailable";
    public static const EVENT_SHOW_MOREAPPS:String = "ShowMoreApps";

    private var _console:TextArea;
	private const spacing:Number = 20;


    private static const BUTTON_HEIGHT : int = 50;

    private var bannerSizePickerList:PickerList;
    private var bannerPositionPickerList:PickerList;
    private var buttonsContainer:LayoutGroup;

	override protected function initialize():void {
		super.initialize();

		initUI();
       initEventListeners();
	}

    private function addButton(label : String, eventName : String, list : PickerList = null) : void {
        var button:Button = new Button();
        button.label = label;
        button.height = BUTTON_HEIGHT;
        button.layoutData = new VerticalLayoutData(80);
        button.addEventListener(Event.TRIGGERED, function ( event : Event ) : void {
			logInConsole(eventName);
            dispatchEventWith(eventName, true, list ? list.selectedItem : null);
		});

		buttonsContainer.addChild(button);
    }

    private function addDropDown(items : Array) : PickerList {
        var list:PickerList = new PickerList();
        list.dataProvider = new ArrayCollection(items);
        list.selectedIndex = 0;
        buttonsContainer.addChild( list );

        return list;
    }

    private function initUI () : void {
        this.title = "Tapdaq";

        this.layout = new AnchorLayout();

        var layoutData = new AnchorLayoutData();
        layoutData.top = 0;
        layoutData.left = 0;
        layoutData.right = 0;
        layoutData.percentHeight = 70;

        var scrollContainer = new ScrollContainer();
        scrollContainer.scrollBarDisplayMode = ScrollBarDisplayMode.FIXED;
        scrollContainer.layout = new AnchorLayout();
        scrollContainer.layoutData = layoutData;
        addChild(scrollContainer);

        scrollContainer.validate();
        var buttonsContainerLayout:VerticalLayout = new VerticalLayout();
        buttonsContainerLayout.gap = 12;
        buttonsContainerLayout.horizontalAlign = HorizontalAlign.CENTER;

        buttonsContainer = new LayoutGroup();
        buttonsContainer.width = stage.stageWidth;
        buttonsContainer.layout = buttonsContainerLayout;
        buttonsContainer.layoutData = new VerticalLayoutData(100);
        scrollContainer.addChild(buttonsContainer);

        addButton("Init Tapdaq",INIT);
        addButton("Load Static Interstitial", LOAD_INTERSTITIAL);
        addButton("Show Static  Interstitial", SHOW_INTERSTITIAL);
        addButton("Load Video Interstitial", LOAD_VIDEO_INTERSTITIAL);
        addButton("Show Video Interstitial", SHOW_VIDEO_INTERSTITIAL);
        addButton("Load Rewarded Interstitial", LOAD_REWARDED_VIDEO_INTERSTITIAL);
        addButton("Show Rewarded Interstitial", SHOW_REWARDED_VIDEO_INTERSTITIAL);

        bannerSizePickerList = addDropDown([Banner.SIZE_STANDARD,Banner.SIZE_MEDIUM_RECT,Banner.SIZE_FULL,Banner.SIZE_LARGE,Banner.SIZE_LEADERBOARD, Banner.SIZE_SMART]);


        addButton("Load Banner", EVENT_LOAD_BANNER, bannerSizePickerList);
        addButton("Is Banner Available?", EVENT_IS_BANNER_AVAILABLE);

        bannerPositionPickerList = addDropDown([Banner.POSITION_TOP,Banner.POSITION_BOTTOM]);
        addButton("Show Banner", EVENT_SHOW_BANNER, bannerPositionPickerList);

        addButton("Destroy Banner", EVENT_DESTROY_BANNER);
        addButton("Load Native Ad", LOAD_NATIVE_AD);
        addButton("Get Native Ad", GET_NATIVE_AD);


        addButton("Load Offerwall", EVENT_LOAD_OFFERWALL);
        addButton("Is Offerwall Available", EVENT_IS_OFFERWALL_AVAILABLE);
        addButton("Show Offerwall", EVENT_SHOW_OFFERWALL);

        addButton("Start Debugger", START_DEBUGGER);

        layoutData = new AnchorLayoutData();
        layoutData.topAnchorDisplayObject = scrollContainer;
        layoutData.top = 0;
        layoutData.bottom = 0;
        layoutData.left = 0;
        layoutData.right = 0;

        _console = new TextArea();
        _console.fontStyles = new TextFormat( "Source Sans Pro,Helvetica,_sans", 10, 0x333333, "left");
        _console.layoutData = layoutData;
        _console.isEditable = false;
        addChild(_console);
    }

	private function initEventListeners() : void {
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_LOAD,onTapdaqEvent);
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_FAIL_LOAD,onTapdaqEvent);
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_SHOW,onTapdaqEvent);
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_CLOSE,onTapdaqEvent);
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_CLICK,onTapdaqEvent);
        Offerwall.getInstance().addEventListener(TapdaqEvent.DID_CUSTOM,onTapdaqEvent);

        MoreApps.getInstance().addEventListener(TapdaqEvent.DID_LOAD,onTapdaqEvent);
        MoreApps.getInstance().addEventListener(TapdaqEvent.DID_FAIL_LOAD,onTapdaqEvent);
        MoreApps.getInstance().addEventListener(TapdaqEvent.DID_SHOW,onTapdaqEvent);
        MoreApps.getInstance().addEventListener(TapdaqEvent.DID_CLICK,onTapdaqEvent);
        MoreApps.getInstance().addEventListener(TapdaqEvent.DID_CLOSE,onTapdaqEvent);

        Banner.getInstance().addEventListener(TapdaqEvent.DID_LOAD,onTapdaqEvent);
        Banner.getInstance().addEventListener(TapdaqEvent.DID_FAIL_LOAD,onTapdaqEvent);
        Banner.getInstance().addEventListener(TapdaqEvent.DID_SHOW,onTapdaqEvent);
        Banner.getInstance().addEventListener(TapdaqEvent.DID_CLOSE,onTapdaqEvent);
        Banner.getInstance().addEventListener(TapdaqEvent.DID_CLICK,onTapdaqEvent);
        Banner.getInstance().addEventListener(TapdaqEvent.DID_REFRESH,onTapdaqEvent);

    }

	private function onTapdaqEvent(event:TapdaqEvent) : void {
        var message : String = "Unknown answer";

        switch (event.type){
            case TapdaqEvent.DID_LOAD:
                message = "Loaded!";
                break;
            case TapdaqEvent.DID_FAIL_LOAD:
                message = "Failed to load with error : " + event.level;
                break;

            case TapdaqEvent.DID_SHOW:
                message = "Did show";
                break;

            case TapdaqEvent.DID_CLOSE:
                message = "Closed";
                break;

            case TapdaqEvent.DID_CUSTOM:
                message = "Custom event received with " + StringUtils.getDictionaryAsString(event.data);
                break;

            case TapdaqEvent.DID_CLICK:
                message = "Clicked!";
                break;

            case TapdaqEvent.DID_REFRESH:
                message = "Refreshed!";
                break;

        }


		logInConsole(message);
	}

    public function logInConsole(text:String):void {
		_console.text += text + "\n";
		_console.text += "----------------\n";
		_console.validate();
		_console.scrollToPosition(_console.horizontalScrollPosition,_console.maxVerticalScrollPosition);
	}


}
}
