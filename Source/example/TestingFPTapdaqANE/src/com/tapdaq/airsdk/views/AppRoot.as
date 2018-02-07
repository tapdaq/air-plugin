package com.tapdaq.airsdk.views {

import com.tapdaq.airsdk.Banner;
import com.tapdaq.airsdk.MoreApps;
import com.tapdaq.airsdk.Offerwall;
import com.tapdaq.airsdk.Tapdaq;
import com.tapdaq.airsdk.model.AdNetworks;
import com.tapdaq.airsdk.model.Placement;
import com.tapdaq.airsdk.model.PlacementTag;
import com.tapdaq.airsdk.model.TapdaqEvent;
import com.tapdaq.airsdk.model.TapdaqNativeAd;
import com.tapdaq.airsdk.model.config.MoreAppsConfig;
import com.tapdaq.airsdk.model.config.TapdaqConfig;
import com.tapdaq.airsdk.model.enums.TapdaqAdType;
import com.tapdaq.airsdk.model.enums.TapdaqCreativeType;
import com.tapdaq.airsdk.model.events.TapdaqAdEvent;
import com.tapdaq.airsdk.model.events.TapdaqNativeAdDataEvent;
import com.tapdaq.airsdk.model.events.TapdaqVerifyAdEvent;
import com.tapdaq.airsdk.utils.AppUtils;
import com.tapdaq.airsdk.utils.StringUtils;

import feathers.controls.LayoutGroup;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.themes.TopcoatLightMobileTheme;

import starling.display.Quad;
import starling.events.Event;
import starling.utils.Color;

public class AppRoot extends LayoutGroup {

	private var _tapdaq:Tapdaq;
	private var _uiView:UIView;
	private var _nativeAd:NativeAd;

	public function AppRoot() {
		super();
		new TopcoatLightMobileTheme();
	}

	override protected function initialize():void {
		super.initialize();

		this.layout = new AnchorLayout();
		this.backgroundSkin = new Quad(1,1, 0x37547d);
		var layoutData:AnchorLayoutData;

		layoutData = new AnchorLayoutData();
		layoutData.top = 0;
		layoutData.left = 0;
		layoutData.right = 0;
		layoutData.bottom = 0;

		_uiView = new UIView();
		_uiView.layoutData = layoutData;
		addChild(_uiView);

		_uiView.addEventListener(UIView.INIT, onActionTriggered);
		_uiView.addEventListener(UIView.LOAD_INTERSTITIAL, onActionTriggered);
		_uiView.addEventListener(UIView.SHOW_INTERSTITIAL, onActionTriggered);
		_uiView.addEventListener(UIView.LOAD_VIDEO_INTERSTITIAL, onActionTriggered);
		_uiView.addEventListener(UIView.SHOW_VIDEO_INTERSTITIAL, onActionTriggered);
        _uiView.addEventListener(UIView.LOAD_REWARDED_VIDEO_INTERSTITIAL, onActionTriggered);
        _uiView.addEventListener(UIView.SHOW_REWARDED_VIDEO_INTERSTITIAL, onActionTriggered);

		_uiView.addEventListener(UIView.EVENT_SHOW_BANNER, onActionTriggered);
        _uiView.addEventListener(UIView.EVENT_IS_BANNER_AVAILABLE, onIsBannerAvailable);
		_uiView.addEventListener(UIView.EVENT_LOAD_BANNER, onActionTriggered);
        _uiView.addEventListener(UIView.EVENT_DESTROY_BANNER, onActionTriggered);

		_uiView.addEventListener(UIView.LOAD_NATIVE_AD, onActionTriggered);
		_uiView.addEventListener(UIView.GET_NATIVE_AD, onActionTriggered);
		_uiView.addEventListener(UIView.START_DEBUGGER, onActionTriggered);

        _uiView.addEventListener(UIView.EVENT_LOAD_OFFERWALL, onLoadOfferwall);
        _uiView.addEventListener(UIView.EVENT_IS_OFFERWALL_AVAILABLE, onIsOfferwallAvailable);
        _uiView.addEventListener(UIView.EVENT_SHOW_OFFERWALL, onShowOfferwall);
        _uiView.addEventListener(UIView.EVENT_LOAD_MOREAPPS, onLoadMoreApps);
        _uiView.addEventListener(UIView.EVENT_IS_MOREAPPS_AVAILABLE, onIsMoreAppsAvailable);
        _uiView.addEventListener(UIView.EVENT_SHOW_MOREAPPS, onShowMoreApps);
    }

    private function onLoadOfferwall(event:Event):void {
		Offerwall.getInstance().load();
    }

    private function onIsOfferwallAvailable(event:Event):void {
        _uiView.logInConsole("Offerwall available : " + Offerwall.getInstance().isAvailable());
    }

    private function onShowOfferwall(event:Event):void {
        Offerwall.getInstance().show();
    }

    private function onLoadMoreApps(event:Event):void {
		var moreAppsConfig = new MoreAppsConfig();
		moreAppsConfig.headerText = "MoreApps Example";
        moreAppsConfig.headerTextColor= Color.SILVER;
        moreAppsConfig.headerCloseButtonColor= Color.RED;
        moreAppsConfig.backgroundColor= Color.GREEN;
        moreAppsConfig.installedButtonText= "Install Me!";

        MoreApps.getInstance().load(moreAppsConfig);
    }

    private function onIsMoreAppsAvailable(event:Event):void {
        _uiView.logInConsole("MoreApps available : " + MoreApps.getInstance().isAvailable());
    }

    private function onIsBannerAvailable(event:Event):void {
        _uiView.logInConsole("Banner available : " + Banner.getInstance().isAvailable());
    }

    private function onShowMoreApps(event:Event):void {
        MoreApps.getInstance().show();
    }

    private function onActionTriggered(event:Event):void {
		var actionID:String = event.type;

		switch (actionID) {
			case UIView.INIT:
				initTapdaq();
				break;
			case UIView.LOAD_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.STATIC_INTERSTITIAL, PlacementTag.MAIN_MENU);
				break;
			case UIView.SHOW_INTERSTITIAL:
				showInterstitial(TapdaqAdType.STATIC_INTERSTITIAL, PlacementTag.MAIN_MENU);
				break;
			case UIView.LOAD_VIDEO_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.VIDEO_INTERSTITIAL);
				break;
			case UIView.SHOW_VIDEO_INTERSTITIAL:
				showInterstitial(TapdaqAdType.VIDEO_INTERSTITIAL);
				break;
			case UIView.LOAD_REWARDED_VIDEO_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.REWARD_INTERSTITIAL, PlacementTag.GAME_OVER);
				break;
			case UIView.SHOW_REWARDED_VIDEO_INTERSTITIAL:
				showInterstitial(TapdaqAdType.REWARD_INTERSTITIAL, PlacementTag.GAME_OVER);
				break;
			case UIView.EVENT_LOAD_BANNER:
				loadBanner(event.data as String);
				break;
			case UIView.EVENT_SHOW_BANNER:
				showBanner(event.data as String);
				break;
            case UIView.EVENT_DESTROY_BANNER:
				destroyBanner();
				break;
			case UIView.LOAD_NATIVE_AD:
				loadNativeAd();
				break;
			case UIView.GET_NATIVE_AD:
				getNativeAd();
				break;
			case UIView.START_DEBUGGER:
				startDebugger();
				break;
		}
	}

	private function initTapdaq():void {
		if(Tapdaq.isSupported ) {
			_uiView.logInConsole("Initializing Tapdaq...");

			var applicationID, clientKey;

            var placements:Array = [
                new Placement([TapdaqCreativeType.REWARDED_VIDEO_INTERSTITIAL],PlacementTag.GAME_OVER),
                new Placement([TapdaqCreativeType.INTERSTITIAL_PORTRAIT, TapdaqCreativeType.SQUARE_LARGE],PlacementTag.MAIN_MENU),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-1"),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-2"),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-3"),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-4"),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-5"),
                new Placement([TapdaqCreativeType.SQUARE_MEDIUM], "tray-position-backfill")
        	];


            if (AppUtils.isIosDevice()) {
                trace("RUNNING ON IOS");
                applicationID = "58d11456162f1b3998b7709b";
                clientKey = "3564a57a-9391-485b-ac01-83efea9b0599";
                placements.push (new Placement([TapdaqCreativeType.VIDEO_INTERSTITIAL,TapdaqCreativeType.OFFERWALL],PlacementTag.DEFAULT));
            } else if (AppUtils.isAndroidDevice()) {
                trace("RUNNING ON ANDROID");
                applicationID = "58a1879f24e637002e48d4d5";
                clientKey = "3564a57a-9391-485b-ac01-83efea9b0599";
                placements.push (new Placement([TapdaqCreativeType.VIDEO_INTERSTITIAL],PlacementTag.DEFAULT));
            }


            var config:TapdaqConfig = new TapdaqConfig(applicationID, clientKey);
			config.debugMode = true;
			config.withPlacementTagSupport(placements);

            config.setTestDevicesForNetwork(AdNetworks.AD_MOB, ["76073D1C4C5BF695E0C2AF9E6A3F8F29","11d3f1932d5103b8f21b4486ce22cccb"]);
			config.setTestDevicesForNetwork(AdNetworks.FACEBOOK, ["78dc424b5a846d61a49d9221844e1858"]);

			_tapdaq = Tapdaq.init(config);

			_tapdaq.addEventListener(TapdaqEvent.DID_INITIALIZE, onTapdaqInitialized);
			_tapdaq.addEventListener(TapdaqAdEvent.AD_LOADED, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.WILL_DISPLAY, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_DISPLAY, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_CLICK, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_CLOSE, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_FAIL_TO_LOAD, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_COMPLETE, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_ENGAGEMENT, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_REWARD_FAIL, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.ON_USER_DECLINED, onAdEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.DID_VERIFY, onDidVerifyEvent);
			_tapdaq.addEventListener(TapdaqAdEvent.NOT_AVAILABLE, onAdEvent);
			_tapdaq.addEventListener(TapdaqNativeAdDataEvent.AD_DATA, onNativeAdData);
		} else {
			_uiView.logInConsole("Tapdaq not supported on this platform");
		}
	}

	private function loadInterstitial(type:TapdaqAdType, tag : String = PlacementTag.DEFAULT):void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading interstitial...");

		_tapdaq.loadInterstitial(type, tag);


	}

	private function showInterstitial(type:TapdaqAdType, tag : String = PlacementTag.DEFAULT):void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Showing interstitial...");

		_tapdaq.showInterstitial(type, tag);

	}

	private function loadBanner(size : String):void {

		if(!_tapdaq) {
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading banner...");
		Banner.getInstance().load(size ? size : Banner.SIZE_STANDARD);
	}

	private function showBanner(position:String):void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Showing banner...");

		Banner.getInstance().show(position? position : Banner.POSITION_TOP);

	}

	private function destroyBanner():void {
		if(!_tapdaq) {
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Destroying banner...");
		Banner.getInstance().hide();

	}

	private function loadNativeAd():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading native ad...");
		_tapdaq.loadNativeAd(TapdaqCreativeType.SQUARE_LARGE, PlacementTag.MAIN_MENU);

	}

	private function getNativeAd():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Getting native ad data...");
		_tapdaq.getNativeAd(TapdaqCreativeType.SQUARE_LARGE, PlacementTag.MAIN_MENU);

	}

	private function startDebugger():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Starting debugger...");
		_tapdaq.startDebugger();

	}

	private function onNativeAdData(event:TapdaqNativeAdDataEvent):void {
        var tapdaqNativeAd:TapdaqNativeAd = event.nativeAd;

		_uiView.logInConsole("Tapdaq Native Ad Data received!");
    	trace(StringUtils.getObjectAsString(tapdaqNativeAd));


		if(_nativeAd) {
			removeChild(_nativeAd);
			_nativeAd.dispose();
		}

		_nativeAd = new NativeAd(tapdaqNativeAd);
		addChild(_nativeAd);
		_nativeAd.validate();
		_nativeAd.x = (this.width - _nativeAd.width) / 2;
		_nativeAd.y = (this.height - _nativeAd.height) / 2;
	}

	private function onAdEvent(event:TapdaqAdEvent):void {
		trace("RECEIVED AD EVENT : ", event.type );
		_uiView.logInConsole("Tapdaq Ad event: " + event.type + " for adType: " + event.adType.value + " and placementTag: " + event.placementTag + " " + (event.error ? ( " Error: " + event.error.message ) : ""));
	}

	private function onDidVerifyEvent(event:TapdaqVerifyAdEvent):void {
		_uiView.logInConsole("Tapdaq Verify Ad event: " + event.type + " for adType: " + event.adType.value + " and placementTag: " + event.placementTag + " " + (event.error ? ( " Error: " + event.error.message ) : ""));
		_uiView.logInConsole("Verify Ad event details: Reward Name: " + event.rewardName + " rewardAmount: " + event.rewardAmount);
	}

	private function onTapdaqInitialized(event:TapdaqEvent):void {
		_uiView.logInConsole("Tapdaq is now initialized");
	}
}
}
