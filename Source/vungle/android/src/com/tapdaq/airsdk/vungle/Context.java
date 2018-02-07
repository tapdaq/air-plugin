package com.tapdaq.airsdk.vungle;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import java.util.HashMap;
import java.util.Map;

public class Context extends FREContext
{
  public void dispose()
  {
  }

  public Map<String, FREFunction> getFunctions()
  {
    Map functions = new HashMap();
    return functions;
  }
}
