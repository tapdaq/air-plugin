/**
 * Created by mateo on 31/10/15.
 */


package com.deloki.tapdaq.views {

import com.deloki.tapdaq.models.Model;
import com.tapdaq.ane.Tapdaq.Tapdaq;
import com.tapdaq.ane.Tapdaq.TapdaqConfig;
import com.tapdaq.ane.Tapdaq.VOs.TapdaqBannerLayout;
import com.tapdaq.ane.Tapdaq.VOs.TapdaqNativeAd;
import com.tapdaq.ane.Tapdaq.VOs.TapdaqPlacement;
import com.tapdaq.ane.Tapdaq.enums.TapdaqAdType;
import com.tapdaq.ane.Tapdaq.enums.TapdaqBannerAdSize;
import com.tapdaq.ane.Tapdaq.enums.TapdaqCreativeType;
import com.tapdaq.ane.Tapdaq.enums.TapdaqPlacementTag;
import com.tapdaq.ane.Tapdaq.events.TapdaqAdEvent;
import com.tapdaq.ane.Tapdaq.events.TapdaqEvent;
import com.tapdaq.ane.Tapdaq.events.TapdaqNativeAdDataEvent;
import com.tapdaq.ane.Tapdaq.events.TapdaqVerifyAdEvent;
import com.tapdaq.ane.tapjoy.TapdaqTapjoy;

import feathers.controls.LayoutGroup;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.themes.TopcoatLightMobileTheme;
import starling.display.Quad;
import starling.events.Event;


public class AppRoot extends LayoutGroup {

	private var _tapdaq:Tapdaq;
	private var _uiView:UIView;
	private var _model:Model;
	private var _nativeAd:NativeAd;

	public function AppRoot() {
		super();

		new TopcoatLightMobileTheme();

	}


	override protected function initialize():void {
		super.initialize();

		this._model = new Model();

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
		_uiView.addEventListener(UIView.DESTROY_BANNER, onActionTriggered);
		_uiView.addEventListener(UIView.SHOW_BANNER, onActionTriggered);
		_uiView.addEventListener(UIView.LOAD_BANNER, onActionTriggered);
		_uiView.addEventListener(UIView.LOAD_NATIVE_AD, onActionTriggered);
		_uiView.addEventListener(UIView.GET_NATIVE_AD, onActionTriggered);
		_uiView.addEventListener(UIView.START_DEBUGGER, onActionTriggered);

	}

	private function onActionTriggered(event:Event):void {

		var actionID:String = event.type;

		switch (actionID)
		{
			case UIView.INIT:
				initTapdaq();
				break;
			case UIView.LOAD_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.STATIC_INTERSTITIAL, TapdaqPlacementTag.TDPTagMainMenu);
				break;
			case UIView.SHOW_INTERSTITIAL:
				showInterstitial(TapdaqAdType.STATIC_INTERSTITIAL, TapdaqPlacementTag.TDPTagMainMenu);
				break;
			case UIView.LOAD_VIDEO_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.VIDEO_INTERSTITIAL, TapdaqPlacementTag.TDPTagDefault);
				break;
			case UIView.SHOW_VIDEO_INTERSTITIAL:
				showInterstitial(TapdaqAdType.VIDEO_INTERSTITIAL, TapdaqPlacementTag.TDPTagDefault);
				break;
			case UIView.LOAD_REWARDED_VIDEO_INTERSTITIAL:
				loadInterstitial(TapdaqAdType.REWARD_INTERSTITIAL, TapdaqPlacementTag.TDPTagGameOver);
				break;
			case UIView.SHOW_REWARDED_VIDEO_INTERSTITIAL:
				showInterstitial(TapdaqAdType.REWARD_INTERSTITIAL, TapdaqPlacementTag.TDPTagGameOver);
				break;
			case UIView.LOAD_BANNER:
				loadBanner();
				break;
			case UIView.SHOW_BANNER:
				showBanner();
				break;
			case UIView.DESTROY_BANNER:
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
		if(Tapdaq.isSupported && !_tapdaq)
		{
			TapdaqTapjoy.init();

			_uiView.logInConsole("Initializing Tapdaq...");

			var config:TapdaqConfig = new TapdaqConfig(_model.applicationID, _model.clientKey);
			var placements:Array = [
				new TapdaqPlacement([TapdaqCreativeType.REWARDED_VIDEO_INTERSTITIAL],TapdaqPlacementTag.TDPTagGameOver),
				new TapdaqPlacement([TapdaqCreativeType.VIDEO_INTERSTITIAL],TapdaqPlacementTag.TDPTagDefault),
				new TapdaqPlacement([TapdaqCreativeType.INTERSTITIAL_PORTRAIT, TapdaqCreativeType.SQUARE_LARGE],TapdaqPlacementTag.TDPTagMainMenu)
			];

			config.debugMode = true;
			config.withPlacementTagSupport(placements);

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


		}
		else
		{
			_tapdaq ?
					_uiView.logInConsole("Tapdaq already initialised") :
					_uiView.logInConsole("Tapdaq not supported on this platform");
		}
	}

	private function loadInterstitial(type:TapdaqAdType, tag:TapdaqPlacementTag):void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading interstitial...");

		_tapdaq.loadInterstitial(type, tag);


	}

	private function showInterstitial(type:TapdaqAdType, tag:TapdaqPlacementTag):void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Showing interstitial...");

		_tapdaq.showInterstitial(type, tag);

	}

	private function loadBanner():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading banner...");
		_tapdaq.loadBanner(TapdaqBannerAdSize.STANDARD);


	}

	private function showBanner():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Showing banner...");

		var bannerLayout:TapdaqBannerLayout = new TapdaqBannerLayout();
		bannerLayout.marginBottom = 50;
		_tapdaq.showBanner(bannerLayout);

	}

	private function destroyBanner():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Destroying banner...");

		_tapdaq.destroyBanner();

	}

	private function loadNativeAd():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Loading native ad...");
		_tapdaq.loadNativeAd(TapdaqCreativeType.SQUARE_LARGE, TapdaqPlacementTag.TDPTagMainMenu);

	}

	private function getNativeAd():void {
		if(!_tapdaq)
		{
			_uiView.logInConsole("Please initialise Tapdaq first");
			return;
		}
		_uiView.logInConsole("Getting native ad data...");
		_tapdaq.getNativeAd(TapdaqCreativeType.SQUARE_LARGE, TapdaqPlacementTag.TDPTagMainMenu);

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
		_uiView.logInConsole("Tapdaq Native Ad event: ");
		_uiView.logInConsole("Ad::appName " + event.nativeAd.appName);
		_uiView.logInConsole("Ad::ageRating " + event.nativeAd.ageRating);
		_uiView.logInConsole("Ad::appVersion " + event.nativeAd.appVersion);
		_uiView.logInConsole("Ad::appSize " + event.nativeAd.appSize);
		_uiView.logInConsole("Ad::averageReview " + event.nativeAd.averageReview);
		_uiView.logInConsole("Ad::callToActionText " + event.nativeAd.callToActionText);
		_uiView.logInConsole("Ad::category " + event.nativeAd.category);
		_uiView.logInConsole("Ad::currency " + event.nativeAd.currency);
		_uiView.logInConsole("Ad::description " + event.nativeAd.description);
		_uiView.logInConsole("Ad::developerName " + event.nativeAd.developerName);
		_uiView.logInConsole("Ad::iconUrl " + event.nativeAd.iconUrl);
		_uiView.logInConsole("Ad::imageUrl " + event.nativeAd.imageUrl);
		_uiView.logInConsole("Ad::price " + event.nativeAd.price);
		_uiView.logInConsole("Ad::title " + event.nativeAd.title);
		_uiView.logInConsole("Ad::totalReviews " + event.nativeAd.totalReviews);

		var tapdaqNativeAd:TapdaqNativeAd = event.nativeAd;

		if(_nativeAd)
		{
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
		_uiView.logInConsole("Tapdaq Ad event: " + event.type + " for adType: " + event.adType.value + " and placementTag: " + event.placementTag.value + " " + (event.error ? ( " Error: " + event.error.message ) : ""));
	}

	private function onDidVerifyEvent(event:TapdaqVerifyAdEvent):void {
		_uiView.logInConsole("Tapdaq Verify Ad event: " + event.type + " for adType: " + event.adType.value + " and placementTag: " + event.placementTag.value + " " + (event.error ? ( " Error: " + event.error.message ) : ""));
		_uiView.logInConsole("Verify Ad event details: Reward Name: " + event.rewardName + " rewardAmount: " + event.rewardAmount);
	}

	private function onTapdaqInitialized(event:TapdaqEvent):void {
		_uiView.logInConsole("Tapdaq is now initialized");
	}
}
}
