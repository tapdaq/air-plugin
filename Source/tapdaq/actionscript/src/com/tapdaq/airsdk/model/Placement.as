package com.tapdaq.airsdk.model {
import com.tapdaq.airsdk.*;

public class Placement {

	public var creativeTypes : Array;
	public var placementTag : String;

	public function Placement(creativeTypes:Array, placementTag : String = PlacementTag.DEFAULT) {
		this.creativeTypes = creativeTypes;
		this.placementTag = placementTag;
	}
}
}
