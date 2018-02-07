package com.tapdaq.airsdk.functions;

import android.util.Log;

import com.adobe.air.AndroidActivityWrapper;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tapdaq.airsdk.CommonEvents;
import com.tapdaq.airsdk.Extension;
import com.tapdaq.airsdk.TapdaqContext;
import com.tapdaq.airsdk.utils.Utils;
import com.tapdaq.sdk.CreativeType;
import com.tapdaq.sdk.Tapdaq;
import com.tapdaq.sdk.TapdaqConfig;
import com.tapdaq.sdk.adnetworks.TMMediationNetworks;
import com.tapdaq.sdk.ads.TapdaqPlacement;
import com.tapdaq.sdk.helpers.TLog;
import com.tapdaq.sdk.helpers.TLogLevel;
import com.tapdaq.sdk.listeners.TMInitListener;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class AirTapdaqInit implements FREFunction {

    @Override
    public FREObject call(final FREContext context, FREObject[] args) {
        try  {

            Log.d("TAPDAQ!!!", "Implemented state listener!!! ");
            AndroidActivityWrapper aa = AndroidActivityWrapper.CreateAndroidActivityWrapper(context.getActivity());
            aa.addActivityStateChangeListner(Extension.getContext(TapdaqContext.TYPE));

            Boolean debugMode = args[7].getAsBool();

            if(debugMode) {
                TLog.setLoggingLevel(TLogLevel.DEBUG);
            } else {
                TLog.setLoggingLevel(TLogLevel.INFO);
            }

            TapdaqConfig config = new TapdaqConfig(context.getActivity());

            String applicationId = args[0].getAsString();
            String clientKey = args[1].getAsString();
            int maxNumberOfCachedAdverts = args[2].getAsInt();

            TapdaqPlacement[] placements = null;
            String supportedPlacementsJSON = args[3].getAsString();
            if ( !supportedPlacementsJSON.equals("")) {
                placements = Utils.parseSupportedPlacements(supportedPlacementsJSON);
            }

            CreativeType[] creativeTypes = null;
            String supportedCreativeTypesJSON = args[4].getAsString();
            if ( !supportedCreativeTypesJSON.equals("")) {
                creativeTypes = Utils.parseCreativeTypes(supportedCreativeTypesJSON);
            }

            //test devices
            Map<Integer, List<String>> testDevices = getTestDevicesFromJSON(args[5].getAsString());
            if (testDevices == null) {
                TLog.error("Some error occured while converting test devices JSON into JAVA object. ");
            } else {
                for (Map.Entry<Integer, List<String>> entry : testDevices.entrySet())  {
                    TLog.debug("set test device id = " + entry.getValue() + " for network " + TMMediationNetworks.getName(entry.getKey()));
                    config.registerTestDevices(entry.getKey(), entry.getValue());
                }
            }

            String pluginVersion= "air_" + args[6].getAsString();
            config.setPluginVersion(pluginVersion);
            TLog.info("Plugin Version " + pluginVersion);

            config.withMaxNumberOfCachedAdverts(maxNumberOfCachedAdverts);

            if(placements != null) {
                config.withPlacementTagSupport(placements);
            }

            if(creativeTypes != null) {
                config.withCreativeTypesSupport(creativeTypes);
            }

            Tapdaq.getInstance().initialize(context.getActivity(), applicationId, clientKey,config, new TMInitListener() {
                @Override
                public void didInitialise() {
                    context.dispatchStatusEventAsync(CommonEvents.AirTapdaqEvent_DID_INITIALIZE, "");
                }
            });

        }
        catch (Exception e)
        {
            context.dispatchStatusEventAsync(CommonEvents.LOGGING, "Error occurred while initialising Tapdaq ANE " + e.getLocalizedMessage());
        }

        return null;
    }

    private Map<Integer, List<String>> getTestDevicesFromJSON(String json) {

        Map<Integer, List<String>> result = new HashMap<Integer, List<String>>();
        try {
            if(json.equals("")){
                return  result;
            }

            JSONArray jsonArray = new JSONArray(json);

            for(int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                result.put(Integer.valueOf(jsonObject.getString("key")), Arrays.asList(Utils.jsonArrayToStringArray(jsonObject.getJSONArray("value"))));
            }

            return result;
        }
        catch (Exception e) {
            return null;
        }
    }

}
