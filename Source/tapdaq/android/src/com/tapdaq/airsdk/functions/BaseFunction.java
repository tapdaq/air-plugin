package com.tapdaq.airsdk.functions;


import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.Extension;

public class BaseFunction {

    protected String getStringProperty(FREObject object, String property)  {
        try {
            FREObject propertyObject = object.getProperty(property);
            if(propertyObject == null){
                return null;
            }
            return getStringFromFREObject(propertyObject);
        } catch (Exception e) {
            Extension.log(e);
            return null;
        }
    }

    protected String getStringFromFREObject(FREObject object) {
        try {
            return object.getAsString();
        } catch (Exception e) {
            Extension.log(e);
            return null;
        }
    }

    protected int getIntProperty(FREObject object, String property) {
        try {
            FREObject propertyObject = object.getProperty(property);
            if(propertyObject == null){
                return 0;
            }
            return getIntFromFREObject(propertyObject);
        }catch (Exception e) {
            Extension.log(e);
            return 0;
        }
    }

    protected int getIntFromFREObject(FREObject object) {
        try {
            return object.getAsInt();
        } catch (Exception e) {
            Extension.log(e);
            return 0;
        }
    }

}
