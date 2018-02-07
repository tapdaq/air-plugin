package com.tapdaq.airsdk.google;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import java.util.HashMap;
import java.util.Map;

public class GoogleContext extends FREContext
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
