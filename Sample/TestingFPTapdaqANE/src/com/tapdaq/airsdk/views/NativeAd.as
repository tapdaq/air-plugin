package com.tapdaq.airsdk.views {
import com.tapdaq.airsdk.model.TapdaqNativeAd;

import feathers.controls.Button;
import feathers.controls.ImageLoader;
import feathers.controls.LayoutGroup;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class NativeAd extends LayoutGroup {

	private var _nativeAd:TapdaqNativeAd;
	private var _image:ImageLoader;
	private var _closeButton:Button;

	public function NativeAd(nativeAd:TapdaqNativeAd) {
		_nativeAd = nativeAd;
	}


	override protected function initialize():void {
		super.initialize();

		this.layout = new AnchorLayout();

		this.width = 100;
		this.height = 140;

		var layoutData:AnchorLayoutData = new AnchorLayoutData();
		layoutData.top = 0;
		layoutData.left = 0;
		layoutData.right = 0;

		_closeButton = new Button();
		_closeButton.height = 40;
		_closeButton.label = "X";
		_closeButton.layoutData = layoutData;
		_closeButton.addEventListener(Event.TRIGGERED, onTriggerClick);
		addChild(_closeButton);

		layoutData = new AnchorLayoutData();
		layoutData.topAnchorDisplayObject = _closeButton;
		layoutData.top = 0;
		layoutData.bottom = 0;
		layoutData.left = 0;
		layoutData.right = 0;

		_image = new ImageLoader();
		_image.source = _nativeAd.imageUrl;
		_image.layoutData = layoutData;
		addChild(_image);
		_image.addEventListener(TouchEvent.TOUCH, onNativeAdTouch);

		_nativeAd.triggerDisplay();

	}

	private function onTriggerClick(event:Event):void {

		this.removeFromParent(true);
	}

	override public function dispose():void {
		super.dispose();
		this._nativeAd = null;
		_closeButton.removeEventListeners();
		_image.removeEventListeners();
	}

	private function onNativeAdTouch(event:TouchEvent):void {
		var touch:Touch = event.getTouch(DisplayObject(event.target), TouchPhase.BEGAN);
		if(!touch)
			return;

		_nativeAd.triggerClick();


	}
}
}
