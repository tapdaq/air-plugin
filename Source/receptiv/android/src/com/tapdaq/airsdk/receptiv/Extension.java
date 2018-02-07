package com.tapdaq.airsdk.receptiv;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class Extension implements FREExtension{
  public FREContext createContext(String args){
    return new Context();
  }

  public void dispose() {}

  public void initialize() {}
}
