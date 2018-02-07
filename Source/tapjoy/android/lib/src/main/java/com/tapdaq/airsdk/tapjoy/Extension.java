package com.tapdaq.airsdk.tapjoy;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class Extension implements FREExtension{
  public static final String TAG = "TapdaqTapjoy";

  public FREContext createContext(String args){
    return new Context();
  }

  public void dispose() {}

  public void initialize() {
  }


}

