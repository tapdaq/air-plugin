package com.tapdaq.airsdk.model.enums {
public class TapdaqCreativeType {

	static public const NONE               : TapdaqCreativeType = new TapdaqCreativeType( "NONE");

	static public const BANNER               : TapdaqCreativeType = new TapdaqCreativeType( "BANNER");
	static public const INTERSTITIAL_LANDSCAPE               : TapdaqCreativeType = new TapdaqCreativeType( "INTERSTITIAL_LANDSCAPE");
	static public const INTERSTITIAL_PORTRAIT  : TapdaqCreativeType = new TapdaqCreativeType( "INTERSTITIAL_PORTRAIT");
	static public const VIDEO_INTERSTITIAL   : TapdaqCreativeType = new TapdaqCreativeType( "VIDEO_INTERSTITIAL");
	static public const REWARDED_VIDEO_INTERSTITIAL  : TapdaqCreativeType = new TapdaqCreativeType( "REWARDED_VIDEO_INTERSTITIAL");

	static public const SQUARE_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "SQUARE_SMALL");
	static public const SQUARE_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "SQUARE_MEDIUM");
	static public const SQUARE_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "SQUARE_LARGE");
	static public const NEWSFEED_TALL_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_TALL_SMALL");
	static public const NEWSFEED_TALL_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_TALL_MEDIUM");
	static public const NEWSFEED_TALL_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_TALL_LARGE");
	static public const NEWSFEED_WIDE_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_WIDE_SMALL");
	static public const NEWSFEED_WIDE_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_WIDE_MEDIUM");
	static public const NEWSFEED_WIDE_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "NEWSFEED_WIDE_LARGE");
	static public const FULLSCREEN_TALL_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_TALL_SMALL");
	static public const FULLSCREEN_TALL_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_TALL_MEDIUM");
	static public const FULLSCREEN_TALL_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_TALL_LARGE");
	static public const FULLSCREEN_WIDE_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_WIDE_SMALL");
	static public const FULLSCREEN_WIDE_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_WIDE_MEDIUM");
	static public const FULLSCREEN_WIDE_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "FULLSCREEN_WIDE_LARGE");
	static public const STRIP_TALL_SMALL  : TapdaqCreativeType = new TapdaqCreativeType("STRIP_TALL_SMALL");
	static public const STRIP_TALL_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "STRIP_TALL_MEDIUM");
	static public const STRIP_TALL_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "STRIP_TALL_LARGE");
	static public const STRIP_WIDE_SMALL  : TapdaqCreativeType = new TapdaqCreativeType( "STRIP_WIDE_SMALL");
	static public const STRIP_WIDE_MEDIUM  : TapdaqCreativeType = new TapdaqCreativeType( "STRIP_WIDE_MEDIUM");
	static public const STRIP_WIDE_LARGE  : TapdaqCreativeType = new TapdaqCreativeType( "STRIP_WIDE_LARGE");

    public static  const OFFERWALL : TapdaqCreativeType = new TapdaqCreativeType( "OFFERWALL");


    private var _value:String = null;

    public function TapdaqCreativeType(value : String) {
        _value = value;
    }


    public static function fromValue(value:String):TapdaqCreativeType {

		switch (value)
		{
			case NONE.value:
				return NONE;
				break;
			case BANNER.value:
				return BANNER;
				break;
			case INTERSTITIAL_LANDSCAPE.value:
				return INTERSTITIAL_LANDSCAPE;
				break;
			case INTERSTITIAL_PORTRAIT.value:
				return INTERSTITIAL_PORTRAIT;
				break;
			case REWARDED_VIDEO_INTERSTITIAL.value:
				return REWARDED_VIDEO_INTERSTITIAL;
				break;
			case VIDEO_INTERSTITIAL.value:
				return VIDEO_INTERSTITIAL;
				break;
			case SQUARE_SMALL.value:
				return SQUARE_SMALL;
				break;
			case SQUARE_MEDIUM.value:
				return SQUARE_MEDIUM;
				break;
			case SQUARE_LARGE.value:
				return SQUARE_LARGE;
				break;
			case NEWSFEED_TALL_SMALL.value:
				return NEWSFEED_TALL_SMALL;
				break;
			case NEWSFEED_TALL_MEDIUM.value:
				return NEWSFEED_TALL_MEDIUM;
				break;
			case NEWSFEED_TALL_LARGE.value:
				return NEWSFEED_TALL_LARGE;
				break;
			case NEWSFEED_WIDE_SMALL.value:
				return NEWSFEED_WIDE_SMALL;
				break;
			case NEWSFEED_WIDE_MEDIUM.value:
				return NEWSFEED_WIDE_MEDIUM;
				break;
			case NEWSFEED_WIDE_LARGE.value:
				return NEWSFEED_WIDE_LARGE;
				break;
			case FULLSCREEN_TALL_SMALL.value:
				return FULLSCREEN_TALL_SMALL;
				break;
			case FULLSCREEN_TALL_MEDIUM.value:
				return FULLSCREEN_TALL_MEDIUM;
				break;
			case FULLSCREEN_TALL_LARGE.value:
				return FULLSCREEN_TALL_LARGE;
				break;
			case FULLSCREEN_WIDE_SMALL.value:
				return FULLSCREEN_WIDE_SMALL;
				break;
			case FULLSCREEN_WIDE_MEDIUM.value:
				return FULLSCREEN_WIDE_MEDIUM;
				break;
			case FULLSCREEN_WIDE_LARGE.value:
				return FULLSCREEN_WIDE_LARGE;
				break;
			case STRIP_TALL_SMALL.value:
				return STRIP_TALL_SMALL;
				break;
			case STRIP_TALL_MEDIUM.value:
				return STRIP_TALL_MEDIUM;
				break;
			case STRIP_TALL_LARGE.value:
				return STRIP_TALL_LARGE;
				break;
			case STRIP_WIDE_SMALL.value:
				return STRIP_WIDE_SMALL;
				break;
			case STRIP_WIDE_MEDIUM.value:
				return STRIP_WIDE_MEDIUM;
				break;
			case STRIP_WIDE_LARGE.value:
				return STRIP_WIDE_LARGE;
				break;
			default:
				return null;
				break;
		}
	}

	public function get value():String {
		return _value;
	}

}
}
