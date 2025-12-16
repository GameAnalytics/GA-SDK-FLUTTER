package com.gameanalytics.sdk.flutter;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.gameanalytics.sdk.GameAnalytics;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** GameAnalyticsPlugin */
public class GameAnalyticsPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware
{
    private MethodChannel channel;
    private Activity activity;
    private static final String VERSION = "1.3.0";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding)
    {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "gameanalytics");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result)
    {
        if (call.method.equals("configureAvailableCustomDimensions01"))
        {
            String customDimensions = call.argument("customDimensions");

            try
            {
                JSONArray jsonArray = new JSONArray(customDimensions);

                ArrayList<String> array = new ArrayList<>();

                for(int i = 0; i < jsonArray.length(); ++i)
                {
                    array.add(jsonArray.optString(i, ""));
                }

                GameAnalytics.configureAvailableCustomDimensions01(array.toArray(new String[0]));
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else if (call.method.equals("configureAvailableCustomDimensions02"))
        {
            String customDimensions = call.argument("customDimensions");

            try
            {
                JSONArray jsonArray = new JSONArray(customDimensions);

                ArrayList<String> array = new ArrayList<>();

                for (int i = 0; i < jsonArray.length(); ++i)
                {
                    array.add(jsonArray.optString(i, ""));
                }

                GameAnalytics.configureAvailableCustomDimensions02(array.toArray(new String[0]));
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else if (call.method.equals("configureAvailableCustomDimensions03"))
        {
            String customDimensions = call.argument("customDimensions");

            try
            {
                JSONArray jsonArray = new JSONArray(customDimensions);

                ArrayList<String> array = new ArrayList<>();

                for (int i = 0; i < jsonArray.length(); ++i)
                {
                    array.add(jsonArray.optString(i, ""));
                }

                GameAnalytics.configureAvailableCustomDimensions03(array.toArray(new String[0]));
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else if (call.method.equals("configureAvailableResourceCurrencies"))
        {
            String resourceCurrencies = call.argument("resourceCurrencies");

            try
            {
                JSONArray jsonArray = new JSONArray(resourceCurrencies);

                ArrayList<String> array = new ArrayList<>();

                for (int i = 0; i < jsonArray.length(); ++i)
                {
                    array.add(jsonArray.optString(i, ""));
                }

                GameAnalytics.configureAvailableResourceCurrencies(array.toArray(new String[0]));
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else if (call.method.equals("configureAvailableResourceItemTypes"))
        {
            String resourceItemTypes = call.argument("resourceItemTypes");

            try
            {
                JSONArray jsonArray = new JSONArray(resourceItemTypes);

                ArrayList<String> array = new ArrayList<>();

                for (int i = 0; i < jsonArray.length(); ++i)
                {
                    array.add(jsonArray.optString(i, ""));
                }

                GameAnalytics.configureAvailableResourceItemTypes(array.toArray(new String[0]));
            }
            catch (JSONException e)
            {
                e.printStackTrace();
            }
        }
        else if (call.method.equals("configureBuild"))
        {
            String build = call.argument("build");
            GameAnalytics.configureBuild(build);
        }
        else if (call.method.equals("configureAutoDetectAppVersion"))
        {
            Boolean flag = call.argument("flag");
            if(flag != null)
            {
                GameAnalytics.configureAutoDetectAppVersion(flag);
            }
            else
            {
                result.error("ERROR", "configureAutoDetectAppVersion: Flag argument could not be parsed to a boolean", null);
            }
        }
        else if (call.method.equals("configureUserId"))
        {
            String uId = call.argument("uId");
            GameAnalytics.configureUserId(uId);
        }
        else if (call.method.equals("initialize"))
        {
            String gameKey = call.argument("gameKey");
            String secretKey = call.argument("secretKey");
            String sdkVersion = "flutter " + VERSION;
            GameAnalytics.configureSdkGameEngineVersion(sdkVersion);
            GameAnalytics.initialize(this.activity, gameKey, secretKey);
        }
        else if (call.method.equals("addBusinessEvent"))
        {
            String currency = call.argument("currency");
            Integer amount = call.argument("amount");
            String itemType = call.argument("itemType");
            String itemId = call.argument("itemId");
            String cartType = call.argument("cartType");
            String fields = "{}";
            if (call.hasArgument("customFields"))
            {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if(amount != null)
            {
                if(call.hasArgument("receipt") && call.hasArgument("signature"))
                {
                    String receipt = call.argument("receipt");
                    String signature = call.argument("signature");
                    GameAnalytics.addBusinessEvent(currency, amount, itemType, itemId, cartType, receipt, "google_play", signature,
                            fields, mergeFields);
                }
                else
                {
                    GameAnalytics.addBusinessEvent(currency, amount, itemType, itemId, cartType, fields, mergeFields);
                }
            }
            else
            {
                result.error("ERROR", "addBusinessEvent: Amount argument could not be parsed to an integer", null);
            }
        }
        else if (call.method.equals("addResourceEvent"))
        {
            Integer flowType = call.argument("flowType");
            String currency = call.argument("currency");
            Number amount = call.argument("amount");
            String itemType = call.argument("itemType");
            String itemId = call.argument("itemId");
            String fields = "{}";
            if (call.hasArgument("customFields")) {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if(flowType != null && amount != null)
            {
                GameAnalytics.addResourceEvent(flowType, currency, amount.floatValue(), itemType, itemId, fields,
                        mergeFields);
            }
            else
            {
                result.error("ERROR", "addResourceEvent: flowType or amount argument could not be parsed to the correct type", null);
            }
        }
        else if (call.method.equals("addProgressionEvent"))
        {
            Integer progressionStatus = call.argument("progressionStatus");
            String progression01 = call.argument("progression01");
            String progression02 = "";
            if(call.hasArgument("progression02"))
            {
                progression02 = call.argument("progression02");
            }
            String progression03 = "";
            if (call.hasArgument("progression03"))
            {
                progression03 = call.argument("progression03");
            }
            Number score = null;
            boolean sendScore = false;
            if (call.hasArgument("score"))
            {
                score = call.argument("score");
                sendScore = true;
            }
            String fields = "{}";
            if (call.hasArgument("customFields")) {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if(progressionStatus != null)
            {
                if (sendScore && score != null)
                {
                    GameAnalytics.addProgressionEvent(progressionStatus, progression01, progression02, progression03, score.doubleValue(), fields,
                            mergeFields);
                }
                else
                {
                    GameAnalytics.addProgressionEvent(progressionStatus, progression01, progression02, progression03,
                            fields, mergeFields);
                }
            }
            else
            {
                result.error("ERROR", "addProgressionEvent: progressionStatus argument could not be parsed to an integer", null);
            }
        }
        else if (call.method.equals("addDesignEvent"))
        {
            String eventId = call.argument("eventId");
            Number value = null;
            boolean sendValue = false;
            if (call.hasArgument("value"))
            {
                value = call.argument("value");
                sendValue = true;
            }
            String fields = "{}";
            if (call.hasArgument("customFields")) {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if (sendValue && value != null)
            {
                GameAnalytics.addDesignEvent(eventId, value.doubleValue(), fields, mergeFields);
            }
            else
            {
                GameAnalytics.addDesignEvent(eventId, fields, mergeFields);
            }
        }
        else if (call.method.equals("addErrorEvent"))
        {
            Integer severity = call.argument("severity");
            String message = call.argument("message");
            String fields = "{}";
            if (call.hasArgument("customFields")) {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if(severity != null)
            {
                GameAnalytics.addErrorEvent(severity, message, fields, mergeFields);
            }
            else
            {
                result.error("ERROR", "addErrorEvent: severity argument could not be parsed to an integer", null);
            }
        }
        else if (call.method.equals("addAdEvent"))
        {
            Integer adAction = call.argument("adAction");
            Integer adType = call.argument("adType");
            String adSdkName = call.argument("adSdkName");
            String adPlacement = call.argument("adPlacement");
            Long duration = null;
            boolean sendDuration = false;
            if (call.hasArgument("duration"))
            {
                duration = call.argument("duration");
                sendDuration = true;
            }
            Integer noAdReason = 0;
            boolean sendNoAdReason = false;
            if (call.hasArgument("noAdReason"))
            {
                noAdReason = call.argument("noAdReason");
                sendNoAdReason = true;
            }
            String fields = "{}";
            if (call.hasArgument("customFields")) {
                fields = call.argument("customFields");
            }
            boolean mergeFields = false;
            if (call.hasArgument("mergeFields")) {
                Boolean b = call.argument("mergeFields");
                mergeFields = b.booleanValue();
            }

            if(adAction != null && adType != null)
            {
                if (sendDuration && duration != null)
                {
                    GameAnalytics.addAdEvent(adAction, adType, adSdkName, adPlacement, duration, fields, mergeFields);
                }
                else if (sendNoAdReason && noAdReason != null)
                {
                    GameAnalytics.addAdEvent(adAction, adType, adSdkName, adPlacement, noAdReason, fields, mergeFields);
                }
                else
                {
                    GameAnalytics.addAdEvent(adAction, adType, adSdkName, adPlacement, fields, mergeFields);
                }
            }
            else
            {
                result.error("ERROR", "addAdEvent: adAction or adType argument could not be parsed to the correct type", null);
            }
        }
        else if (call.method.equals("setEnabledInfoLog"))
        {
            Boolean flag = call.argument("flag");

            if(flag != null)
            {
                GameAnalytics.setEnabledInfoLog(flag);
            }
            else
            {
                result.error("ERROR", "setEnabledInfoLog: Flag argument could not be parsed to a boolean", null);
            }
        }
        else if (call.method.equals("setEnabledVerboseLog"))
        {
            Boolean flag = call.argument("flag");

            if(flag != null)
            {
                GameAnalytics.setEnabledVerboseLog(flag);
            }
            else
            {
                result.error("ERROR", "setEnabledVerboseLog: Flag argument could not be parsed to a boolean", null);
            }
        }
        else if (call.method.equals("setEnabledManualSessionHandling"))
        {
            Boolean flag = call.argument("flag");

            if(flag != null)
            {
                GameAnalytics.setEnabledManualSessionHandling(flag);
            }
            else
            {
                result.error("ERROR", "setEnabledManualSessionHandling: Flag argument could not be parsed to a boolean", null);
            }
        }
        else if (call.method.equals("setEnabledEventSubmission"))
        {
            Boolean flag = call.argument("flag");

            if(flag != null)
            {
                GameAnalytics.setEnabledEventSubmission(flag);
            }
            else
            {
                result.error("ERROR", "setEnabledEventSubmission: Flag argument could not be parsed to a boolean", null);
            }
        }
        else if (call.method.equals("setCustomDimension01"))
        {
            String dimension = call.argument("dimension");
            GameAnalytics.setCustomDimension01(dimension);
        }
        else if (call.method.equals("setCustomDimension02"))
        {
            String dimension = call.argument("dimension");
            GameAnalytics.setCustomDimension02(dimension);
        }
        else if (call.method.equals("setCustomDimension03"))
        {
            String dimension = call.argument("dimension");
            GameAnalytics.setCustomDimension03(dimension);
        }
        else if (call.method.equals("setGlobalCustomEventFields"))
        {
            String customFields = call.argument("customFields");
            GameAnalytics.setGlobalCustomEventFields(customFields);
        }
        else if (call.method.equals("startSession"))
        {
            GameAnalytics.startSession();
        }
        else if (call.method.equals("endSession"))
        {
            GameAnalytics.endSession();
        }
        else if (call.method.equals("getRemoteConfigsValueAsString"))
        {
            String key = call.argument("key");
            String defaultValue = null;

            if (call.hasArgument("defaultValue"))
            {
                defaultValue = call.argument("defaultValue");
            }

            String returnValue;
            if (defaultValue != null)
            {
                returnValue = GameAnalytics.getRemoteConfigsValueAsString(key, defaultValue);
            }
            else
            {
                returnValue = GameAnalytics.getRemoteConfigsValueAsString(key);
            }
            result.success(returnValue);
        }
        else if (call.method.equals("isRemoteConfigsReady"))
        {
            result.success(GameAnalytics.isRemoteConfigsReady());
        }
        else if (call.method.equals("getRemoteConfigsContentAsString"))
        {
            result.success(GameAnalytics.getRemoteConfigsContentAsString());
        }
        else if (call.method.equals("getABTestingId"))
        {
            result.success(GameAnalytics.getABTestingId());
        }
        else if (call.method.equals("getABTestingVariantId"))
        {
            result.success(GameAnalytics.getABTestingVariantId());
        }
        else
        {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding)
    {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding)
    {
        this.activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges()
    {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding)
    {

    }

    @Override
    public void onDetachedFromActivity()
    {
        this.activity = null;
    }
}
