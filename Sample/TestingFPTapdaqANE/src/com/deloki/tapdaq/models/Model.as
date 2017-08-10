/**
 * Created by Mateo Kozomara (mateo.kozomara@gmail.com) on 30/01/2017.
 */
package com.deloki.tapdaq.models {
import flash.system.Capabilities;

public class Model {

	private var _applicationID:String;
	private var _clientKey:String;

	public function Model() {
		if(Capabilities.version.toLowerCase().indexOf("ios") > -1)
		{
			trace("RUNNING ON IOS");
			_applicationID = "<APP_ID>";
			_clientKey = "<CLIENT_KEY>";
		}
		else if(Capabilities.version.toLowerCase().indexOf("and") > -1)
		{
			trace("RUNNING ON ANDROID");
			_applicationID = "<APP_ID>";
			_clientKey = "<CLIENT_KEY>";
		}
	}

	public function get applicationID():String {
		return _applicationID;
	}

	public function get clientKey():String {
		return _clientKey;
	}
}
}
