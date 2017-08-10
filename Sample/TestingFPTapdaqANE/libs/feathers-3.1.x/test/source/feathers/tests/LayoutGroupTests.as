package feathers.tests
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.tests.supportClasses.AssertViewPortBoundsLayout;
	import feathers.tests.supportClasses.DisposeFlagQuad;

	import org.flexunit.Assert;

	import starling.display.Quad;
	import starling.events.Event;

	public class LayoutGroupTests
	{
		//note: the background width is purposefully smaller than the item width
		private static const BACKGROUND_WIDTH:Number = 200;
		//note: the background height is purposefully larger than the item height
		private static const BACKGROUND_HEIGHT:Number = 250;
		
		private static const LARGE_BACKGROUND_WIDTH:Number = 400;
		private static const LARGE_BACKGROUND_HEIGHT:Number = 400;

		//note: the item width is purposefully larger than the background width
		private static const ITEM_WIDTH:Number = 210;
		//note: the item height is purposefully smaller than the background height
		private static const ITEM_HEIGHT:Number = 160;

		private var _group:LayoutGroup;

		[Before]
		public function prepare():void
		{
			this._group = new LayoutGroup();
			TestFeathers.starlingRoot.addChild(this._group);
			this._group.validate();
		}

		[After]
		public function cleanup():void
		{
			this._group.removeFromParent(true);
			this._group = null;

			Assert.assertStrictlyEquals("Child not removed from Starling root on cleanup.", 0, TestFeathers.starlingRoot.numChildren);
		}

		[Test]
		public function testResizeBackgroundWithSmallerMaxDimensions():void
		{
			this._group.maxWidth = BACKGROUND_WIDTH / 3;
			this._group.maxHeight = BACKGROUND_HEIGHT / 3;
			var backgroundSkin:Quad = new Quad(BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
			this._group.backgroundSkin = backgroundSkin;
			this._group.validate();
			Assert.assertStrictlyEquals("The LayoutGroup with smaller maxWidth did not set the width of the background skin.",
				this._group.maxWidth, backgroundSkin.width);
			Assert.assertStrictlyEquals("The LayoutGroup with smaller maxHeight did not set the height of the background skin.",
				this._group.maxHeight, backgroundSkin.height);
		}

		[Test]
		public function testResizeBackgroundWithLargerMinDimensions():void
		{
			this._group.minWidth = 3 * BACKGROUND_WIDTH;
			this._group.minHeight = 3 * BACKGROUND_HEIGHT;
			var backgroundSkin:Quad = new Quad(BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
			this._group.backgroundSkin = backgroundSkin;
			this._group.validate();
			Assert.assertStrictlyEquals("The LayoutGroup with larger minWidth did not set the width of the background skin.",
				this._group.minWidth, backgroundSkin.width);
			Assert.assertStrictlyEquals("The LayoutGroup with larger minHeight did not set the height of the background skin.",
				this._group.minHeight, backgroundSkin.height);
		}

		[Test]
		public function testNoErrorValidatingWithoutStage():void
		{
			var group:LayoutGroup = new LayoutGroup();
			group.validate();
			group.dispose();
		}

		[Test]
		public function testDefaultAutoSizeMode():void
		{
			this._group.validate();
			Assert.assertStrictlyEquals("The default value of LayoutGroup autoSizeMode must be AutoSizeMode.CONTENT, if not root.", AutoSizeMode.CONTENT, this._group.autoSizeMode);
		}

		[Test]
		public function testChildPositionWithLargerBackground():void
		{
			var child:Quad = new Quad(ITEM_WIDTH, ITEM_HEIGHT);
			this._group.addChild(child);
			this._group.backgroundSkin = new Quad(LARGE_BACKGROUND_WIDTH, LARGE_BACKGROUND_HEIGHT);
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			this._group.layout = layout;
			this._group.validate();
			Assert.assertTrue("The layout group does not account for the background skin width when passing bounds to the layout.",
				child.x > 0);
			Assert.assertTrue("The layout group does not account for the background skin width when passing bounds to the layout.",
				child.y > 0);
		}

		[Test]
		public function testResizeWhenAddingChild():void
		{
			var originalWidth:Number = this._group.width;
			var originalHeight:Number = this._group.height;
			var hasResized:Boolean = false;
			this._group.addEventListener(Event.RESIZE, function(event:Event):void
			{
				hasResized = true;
			});
			this._group.addChild(new Quad(ITEM_WIDTH, ITEM_HEIGHT));
			this._group.validate();
			Assert.assertTrue("Event.RESIZE was not dispatched", hasResized);
			Assert.assertFalse("The width of the layout group was not changed.",
				originalWidth === this._group.width);
			Assert.assertFalse("The height of the layout group was not changed.",
				originalHeight === this._group.height);
		}

		[Test]
		public function testResizeWhenRemovingChild():void
		{
			var child:Quad = new Quad(ITEM_WIDTH, ITEM_HEIGHT);
			this._group.addChild(child);
			this._group.validate();
			var originalWidth:Number = this._group.width;
			var originalHeight:Number = this._group.height;

			var hasResized:Boolean = false;
			this._group.addEventListener(Event.RESIZE, function(event:Event):void
			{
				hasResized = true;
			});
			this._group.removeChild(child);
			this._group.validate();
			Assert.assertTrue("Event.RESIZE was not dispatched", hasResized);
			Assert.assertFalse("The width of the layout group was not changed.",
				originalWidth === this._group.width);
			Assert.assertFalse("The height of the layout group was not changed.",
				originalHeight === this._group.height);
		}

		[Test]
		public function testResizeWhenResizingFeathersControlChild():void
		{
			var child:Button = new Button();
			child.defaultSkin = new Quad(ITEM_WIDTH, ITEM_HEIGHT);
			this._group.addChild(child);
			this._group.validate();

			var originalWidth:Number = this._group.width;
			var originalHeight:Number = this._group.height;
			var hasResized:Boolean = false;
			this._group.addEventListener(Event.RESIZE, function(event:Event):void
			{
				hasResized = true;
			});
			child.width = ITEM_WIDTH * 2;
			child.height = ITEM_HEIGHT * 2;
			this._group.validate();
			Assert.assertTrue("Event.RESIZE was not dispatched", hasResized);
			Assert.assertFalse("The width of the layout group was not changed.",
				originalWidth === this._group.width);
			Assert.assertFalse("The height of the layout group was not changed.",
				originalHeight === this._group.height);
		}

		[Test]
		public function testSkinsDisposed():void
		{
			var backgroundSkin:DisposeFlagQuad = new DisposeFlagQuad();
			this._group.backgroundSkin = backgroundSkin;
			var backgroundDisabledSkin:DisposeFlagQuad = new DisposeFlagQuad();
			this._group.backgroundDisabledSkin = backgroundDisabledSkin;
			this._group.validate();
			this._group.dispose();
			Assert.assertTrue("backgroundSkin not disposed when LayoutGroup disposed.", backgroundSkin.isDisposed);
			Assert.assertTrue("backgroundDisabledSkin not disposed when LayoutGroup disposed.", backgroundDisabledSkin.isDisposed);
		}

		[Test]
		public function testViewPortBoundsValues():void
		{
			this._group.layout = new AssertViewPortBoundsLayout();
			this._group.validate();
		}
	}
}