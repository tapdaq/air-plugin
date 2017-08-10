/**
 * Created by Mateo Kozomara (mateo.kozomara@gmail.com) on 05/11/15.
 */
package com.deloki.tapdaq.views {

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.PanelScreen;
import feathers.controls.ScrollBarDisplayMode;
import feathers.controls.ScrollContainer;
import feathers.controls.TextArea;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

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
	public static const DESTROY_BANNER:String = "destroyBanner";
	public static const SHOW_BANNER:String = "showBanner";
	public static const LOAD_BANNER:String = "loadBanner";
	public static const LOAD_NATIVE_AD:String = "loadNativeAd";
	public static const GET_NATIVE_AD:String = "getNativeAd";
	public static const START_DEBUGGER:String = "startDebugger";

	private var _console:TextArea;
	private const spacing:Number = 20;



	override protected function initialize():void {

		super .initialize();


		this.layout = new AnchorLayout();
		this.title = "Tapdaq";

		var layoutData:AnchorLayoutData;

		layoutData = new AnchorLayoutData();
		layoutData.top = 0;
		layoutData.left = 0;
		layoutData.right = 0;
		layoutData.percentHeight = 70;
		layoutData.percentWidth = 100;

		var scrollContainer:ScrollContainer = new ScrollContainer();
		scrollContainer.scrollBarDisplayMode = ScrollBarDisplayMode.FIXED;
		scrollContainer.layoutData = layoutData;
		scrollContainer.layout = new AnchorLayout();
		addChild(scrollContainer);

		layoutData = new AnchorLayoutData();
		layoutData.top = 0;
		layoutData.left = 0;
		layoutData.right = 0;

		var contentContainer:LayoutGroup = new LayoutGroup();
		contentContainer.layout = new AnchorLayout();
		contentContainer.layoutData = layoutData;
		scrollContainer.addChild(contentContainer);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.left = spacing;
		layoutData.right = spacing;

		var button:Button = createButton("Init Tapdaq");
		button.layoutData = layoutData;
		button.name = INIT;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Load Static Interstitial");
		button.layoutData = layoutData;
		button.name = LOAD_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Show Static  Interstitial");
		button.layoutData = layoutData;
		button.name = SHOW_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Load Video Interstitial");
		button.layoutData = layoutData;
		button.name = LOAD_VIDEO_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Show Video Interstitial");
		button.layoutData = layoutData;
		button.name = SHOW_VIDEO_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Load Rewarded Interstitial");
		button.layoutData = layoutData;
		button.name = LOAD_REWARDED_VIDEO_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Show Rewarded Interstitial");
		button.layoutData = layoutData;
		button.name = SHOW_REWARDED_VIDEO_INTERSTITIAL;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Load Banner");
		button.layoutData = layoutData;
		button.name = LOAD_BANNER;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Show Banner");
		button.layoutData = layoutData;
		button.name = SHOW_BANNER;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Destroy Banner");
		button.layoutData = layoutData;
		button.name = DESTROY_BANNER;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Load Native Ad");
		button.layoutData = layoutData;
		button.name = LOAD_NATIVE_AD;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;

		button = createButton("Get Native Ad");
		button.layoutData = layoutData;
		button.name = GET_NATIVE_AD;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = spacing;
		layoutData.topAnchorDisplayObject = button;
		layoutData.left = spacing;
		layoutData.right = spacing;
		layoutData.bottom = spacing;

		button = createButton("Start Debugger");
		button.layoutData = layoutData;
		button.name = START_DEBUGGER;
		button.addEventListener(Event.TRIGGERED, onButtonTriggered);
		contentContainer.addChild(button);

		layoutData = new AnchorLayoutData();
		layoutData.top = 0;
		layoutData.topAnchorDisplayObject = scrollContainer;
		layoutData.bottom = 0;
		layoutData.left = 0;
		layoutData.right = 0;

		_console = new TextArea();
		_console.fontStyles = new TextFormat( "Source Sans Pro,Helvetica,_sans", 10, 0x333333, "left");
		_console.layoutData = layoutData;
		_console.isEditable = false;
		addChild(_console);


	}

	public function logInConsole(text:String):void {
		_console.text += text + "\n";
		_console.text += "----------------\n";
		_console.validate();
		_console.scrollToPosition(_console.horizontalScrollPosition,_console.maxVerticalScrollPosition);
	}

	private function createButton(label:String):Button {
		const buttonHeight:Number = 50;
		var button:Button = new Button();
		button.label = label;
		button.height = buttonHeight;
		return button;
	}

	private function onButtonTriggered(event:Event):void {

		var args:Array = null;

		var button:Button = Button(event.target);
		this.dispatchEventWith(button.name, true, args);
	}

}
}
