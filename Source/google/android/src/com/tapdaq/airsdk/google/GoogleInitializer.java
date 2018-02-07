package com.tapdaq.airsdk.google;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GoogleInitializer
  implements FREExtension
{
  public FREContext createContext(String args)
  {
    return new GoogleContext();
  }

  public void dispose() {}

  public void initialize() {}
}
