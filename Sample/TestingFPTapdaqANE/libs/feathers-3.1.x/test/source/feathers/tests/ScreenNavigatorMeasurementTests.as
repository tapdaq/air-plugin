package feathers.tests
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;

	import org.flexunit.Assert;

	import starling.display.Quad;

	public class ScreenNavigatorMeasurementTests
	{
		private static const SCREEN_ID_ONE:String = "one";
		private static const SCREEN_ONE_WIDTH:Number = 100;
		private static const SCREEN_ONE_HEIGHT:Number = 150;

		private static const SCREEN_ID_TWO:String = "two";
		private static const SCREEN_TWO_WIDTH:Number = 200;
		private static const SCREEN_TWO_HEIGHT:Number = 180;
		private static const SCREEN_TWO_MIN_WIDTH:Number = 110;
		private static const SCREEN_TWO_MIN_HEIGHT:Number = 120;

		private var _navigator:ScreenNavigator;
		private var _navigator2:ScreenNavigator;
		private var _screenOne:Quad;
		private var _screenTwo:LayoutGroup;

		[Before]
		public function prepare():void
		{
			this._screenOne = new Quad(SCREEN_ONE_WIDTH, SCREEN_ONE_HEIGHT, 0xff0000);

			var screenTwoBackground:Quad = new Quad(SCREEN_TWO_WIDTH, SCREEN_TWO_HEIGHT, 0x0000ff);
			this._screenTwo = new LayoutGroup();
			this._screenTwo.minWidth = SCREEN_TWO_MIN_WIDTH;
			this._screenTwo.minHeight = SCREEN_TWO_MIN_HEIGHT;
			this._screenTwo.backgroundSkin = screenTwoBackground;

			this._navigator = new ScreenNavigator();
			this._navigator.addScreen(SCREEN_ID_ONE, new ScreenNavigatorItem(this._screenOne));
			this._navigator.addScreen(SCREEN_ID_TWO, new ScreenNavigatorItem(this._screenTwo));
			TestFeathers.starlingRoot.addChild(this._navigator);
		}

		[After]
		public function cleanup():void
		{
			this._navigator.removeFromParent(true);
			this._navigator = null;

			if(this._navigator2)
			{
				this._navigator2.removeFromParent(true);
				this._navigator2 = null;
			}

			Assert.assertStrictlyEquals("Child not removed from Starling root on cleanup.", 0, TestFeathers.starlingRoot.numChildren);
		}

		[Test]
		public function testAutoSizeModeStage():void
		{
			this._navigator.autoSizeMode = AutoSizeMode.STAGE;
			this._navigator.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator.minHeight);
		}

		[Test]
		public function testAutoSizeModeStageWithoutParent():void
		{
			this._navigator2 = new ScreenNavigator();
			this._navigator2.autoSizeMode = AutoSizeMode.STAGE;
			this._navigator2.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly with no parent and AutoSizeMode.STAGE.",
				0, this._navigator2.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly with no parent and AutoSizeMode.STAGE.",
				0, this._navigator2.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly with no parent and AutoSizeMode.STAGE.",
				0, this._navigator2.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly with no parent and AutoSizeMode.STAGE.",
				0, this._navigator2.minHeight);
		}

		[Test]
		public function testAutoSizeModeStageWithValidateBeforeAdd():void
		{
			this._navigator2 = new ScreenNavigator();
			this._navigator2.autoSizeMode = AutoSizeMode.STAGE;
			this._navigator2.validate();
			TestFeathers.starlingRoot.addChild(this._navigator2);
			this._navigator2.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly after addChild() when validated before with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator2.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly after addChild() when validated before with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator2.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly after addChild() when validated before with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator2.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly after addChild() when validated before with AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator2.minHeight);
		}

		[Test]
		public function testAutoSizeModeContentWithNoActiveScreen():void
		{
			this._navigator.autoSizeMode = AutoSizeMode.CONTENT;
			this._navigator.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.CONTENT.",
				0, this._navigator.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.CONTENT.",
				0, this._navigator.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.CONTENT.",
				0, this._navigator.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly when empty with AutoSizeMode.CONTENT.",
				0, this._navigator.minHeight);
		}

		[Test]
		public function testAutoSizeModeStageWithSimpleScreen():void
		{
			this._navigator.autoSizeMode = AutoSizeMode.STAGE;
			this._navigator.showScreen(SCREEN_ID_ONE);
			this._navigator.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageWidth, this._navigator.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.STAGE.",
				TestFeathers.starlingRoot.stage.stageHeight, this._navigator.minHeight);
		}

		[Test]
		public function testAutoSizeModeContentWithSimpleScreen():void
		{
			this._navigator.autoSizeMode = AutoSizeMode.CONTENT;
			this._navigator.showScreen(SCREEN_ID_ONE);
			this._navigator.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.CONTENT.",
				SCREEN_ONE_WIDTH, this._navigator.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.CONTENT.",
				SCREEN_ONE_HEIGHT, this._navigator.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.CONTENT.",
				SCREEN_ONE_WIDTH, this._navigator.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly with simple screen and AutoSizeMode.CONTENT.",
				SCREEN_ONE_HEIGHT, this._navigator.minHeight);
		}

		[Test]
		public function testAutoSizeModeContentWithComplexScreen():void
		{
			this._navigator.autoSizeMode = AutoSizeMode.CONTENT;
			this._navigator.showScreen(SCREEN_ID_TWO);
			this._navigator.validate();
			Assert.assertStrictlyEquals("The width of the ScreenNavigator was not calculated correctly with complex screen and AutoSizeMode.CONTENT.",
				SCREEN_TWO_WIDTH, this._navigator.width);
			Assert.assertStrictlyEquals("The height of the ScreenNavigator was not calculated correctly with complex screen and AutoSizeMode.CONTENT.",
				SCREEN_TWO_HEIGHT, this._navigator.height);
			Assert.assertStrictlyEquals("The minWidth of the ScreenNavigator was not calculated correctly with complex screen and AutoSizeMode.CONTENT.",
				SCREEN_TWO_MIN_WIDTH, this._navigator.minWidth);
			Assert.assertStrictlyEquals("The minHeight of the ScreenNavigator was not calculated correctly with complex screen and AutoSizeMode.CONTENT.",
				SCREEN_TWO_MIN_HEIGHT, this._navigator.minHeight);
		}
	}
}
