package feathers.examples.componentsExplorer.themes
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import feathers.examples.componentsExplorer.data.EmbeddedAssets;
	import feathers.examples.componentsExplorer.screens.AutoCompleteScreen;
	import feathers.examples.componentsExplorer.screens.ButtonScreen;
	import feathers.examples.componentsExplorer.screens.CalloutScreen;
	import feathers.examples.componentsExplorer.screens.CheckScreen;
	import feathers.examples.componentsExplorer.screens.DateTimeSpinnerScreen;
	import feathers.examples.componentsExplorer.screens.ItemRendererScreen;
	import feathers.examples.componentsExplorer.screens.LabelScreen;
	import feathers.examples.componentsExplorer.screens.ProgressBarScreen;
	import feathers.examples.componentsExplorer.screens.RadioScreen;
	import feathers.examples.componentsExplorer.screens.SliderScreen;
	import feathers.examples.componentsExplorer.screens.TextCalloutScreen;
	import feathers.examples.componentsExplorer.screens.TextInputScreen;
	import feathers.examples.componentsExplorer.screens.ToggleSwitchScreen;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;

	public class ComponentsExplorerTheme extends MetalWorksMobileTheme
	{
		public function ComponentsExplorerTheme()
		{
			super();
		}

		override protected function initializeStyleProviders():void
		{
			super.initializeStyleProviders();

			this.getStyleProviderForClass(AutoCompleteScreen).defaultStyleFunction = this.setAutoCompleteScreenStyles;

			this.getStyleProviderForClass(ButtonScreen).defaultStyleFunction = this.setButtonScreenStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ButtonScreen.CHILD_STYLE_NAME_ICON_BUTTON, this.setButtonScreenIconButtonStyles);

			this.getStyleProviderForClass(CalloutScreen).defaultStyleFunction = this.setCalloutScreenStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(CalloutScreen.CHILD_STYLE_NAME_CALLOUT_HEADER, this.setCalloutHeaderStyles);

			this.getStyleProviderForClass(CheckScreen).defaultStyleFunction = this.setCheckScreenStyles;
			this.getStyleProviderForClass(DateTimeSpinnerScreen).defaultStyleFunction = this.setDateTimeSpinnerScreenStyles;
			this.getStyleProviderForClass(LabelScreen).defaultStyleFunction = this.setLabelScreenStyles;
			this.getStyleProviderForClass(ItemRendererScreen).defaultStyleFunction = this.setItemRendererScreenStyles;
			this.getStyleProviderForClass(ProgressBarScreen).defaultStyleFunction = this.setProgressBarScreenStyles;
			this.getStyleProviderForClass(RadioScreen).defaultStyleFunction = this.setRadioScreenStyles;
			this.getStyleProviderForClass(SliderScreen).defaultStyleFunction = this.setSliderScreenStyles;
			this.getStyleProviderForClass(TextCalloutScreen).defaultStyleFunction = this.setTextCalloutScreenStyles;
			this.getStyleProviderForClass(TextInputScreen).defaultStyleFunction = this.setTextInputScreenStyles;
			this.getStyleProviderForClass(ToggleSwitchScreen).defaultStyleFunction = this.setToggleSwitchScreenStyles;
		}
		
		protected function setAutoCompleteScreenStyles(screen:AutoCompleteScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setButtonScreenIconButtonStyles(button:Button):void
		{
			//don't forget to set styles from the super class, if required
			this.setButtonStyles(button);

			var icon:ImageLoader = new ImageLoader();
			icon.source = EmbeddedAssets.SKULL_ICON_DARK;
			button.defaultIcon = icon;
		}

		protected function setButtonScreenStyles(screen:ButtonScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setCheckScreenStyles(screen:CheckScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.LEFT;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setCalloutScreenStyles(screen:CalloutScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setCalloutHeaderStyles(header:Header):void
		{
			header.fontStyles = this.largeLightFontStyles;
			header.disabledFontStyles = this.largeLightFontStyles;
			header.paddingBottom = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
		}

		protected function setDateTimeSpinnerScreenStyles(screen:DateTimeSpinnerScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.MIDDLE;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;
		}

		protected function setItemRendererScreenStyles(screen:ItemRendererScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			screen.itemRendererGap = this.gutterSize;
		}

		protected function setLabelScreenStyles(screen:LabelScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setProgressBarScreenStyles(screen:ProgressBarScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			layout.gap = this.gutterSize;
			screen.layout = layout;
		}

		protected function setRadioScreenStyles(screen:RadioScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.LEFT;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setSliderScreenStyles(screen:SliderScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			layout.gap = this.gutterSize;
			screen.layout = layout;
		}

		protected function setTextCalloutScreenStyles(screen:TextCalloutScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);

			screen.layoutPadding = this.gutterSize;
		}

		protected function setTextInputScreenStyles(screen:TextInputScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.TOP;
			verticalLayout.padding = this.gutterSize;
			verticalLayout.gap = this.smallGutterSize;
			screen.layout = verticalLayout;

			screen.verticalScrollPolicy = PanelScreen.SCROLL_POLICY_ON;
		}

		protected function setToggleSwitchScreenStyles(screen:ToggleSwitchScreen):void
		{
			//don't forget to set styles from the super class, if required
			this.setPanelScreenStyles(screen);
			
			var layout:TiledRowsLayout = new TiledRowsLayout();
			layout.requestedColumnCount = 2;
			layout.useSquareTiles = false;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.TOP;
			layout.tileHorizontalAlign = HorizontalAlign.CENTER;
			layout.tileVerticalAlign = VerticalAlign.TOP;
			layout.padding = this.gutterSize;
			layout.horizontalGap = this.gutterSize;
			layout.verticalGap = this.gridSize;
			screen.layout = layout;
		}
	}
}
