package com.tapdaq.airsdk.tapjoy;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.tapdaq.airsdk.tapjoy.functions.Init;

import java.util.HashMap;
import java.util.Map;

public class Context extends FREContext
{
  public void dispose() {
  }

  public Map<String, FREFunction> getFunctions() {
    Map functions = new HashMap();
    functions.put("Init", new Init());
    return functions;
  }


  public Context() {
    Log.d("fadfas", "Creating context!!!");
    //getActivity().getResources();

  }
}
