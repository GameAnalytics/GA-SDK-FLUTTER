#import "GameAnalyticsPlugin.h"
#import <GameAnalytics/GameAnalytics.h>

#define VERSION @"1.3.0"

@implementation GameAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"gameanalytics" binaryMessenger:[registrar messenger]];
    GameAnalyticsPlugin* instance = [[GameAnalyticsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method])
    {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    else if ([@"configureAvailableCustomDimensions01" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *customDimensions = args[@"customDimensions"];
        NSArray *list_array = nil;
        if (customDimensions) {
            list_array = [NSJSONSerialization JSONObjectWithData:[customDimensions dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics configureAvailableCustomDimensions01:list_array];
    }
    else if ([@"configureAvailableCustomDimensions02" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *customDimensions = args[@"customDimensions"];
        NSArray *list_array = nil;
        if (customDimensions) {
            list_array = [NSJSONSerialization JSONObjectWithData:[customDimensions dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics configureAvailableCustomDimensions02:list_array];
    }
    else if ([@"configureAvailableCustomDimensions03" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *customDimensions = args[@"customDimensions"];
        NSArray *list_array = nil;
        if (customDimensions) {
            list_array = [NSJSONSerialization JSONObjectWithData:[customDimensions dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics configureAvailableCustomDimensions03:list_array];
    }
    else if ([@"configureAvailableResourceCurrencies" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *resourceCurrencies = args[@"resourceCurrencies"];
        NSArray *list_array = nil;
        if (resourceCurrencies) {
            list_array = [NSJSONSerialization JSONObjectWithData:[resourceCurrencies dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics configureAvailableResourceCurrencies:list_array];
    }
    else if ([@"configureAvailableResourceItemTypes" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *resourceItemTypes = args[@"resourceItemTypes"];
        NSArray *list_array = nil;
        if (resourceItemTypes) {
            list_array = [NSJSONSerialization JSONObjectWithData:[resourceItemTypes dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics configureAvailableResourceItemTypes:list_array];
    }
    else if ([@"configureBuild" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *build = args[@"build"];
        if(build == nil)
        {
            build = @"";
        }
        [GameAnalytics configureBuild:build];
    }
    else if ([@"configureAutoDetectAppVersion" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        BOOL flag = [args[@"flag"] boolValue];
        [GameAnalytics configureAutoDetectAppVersion:flag];
    }
    else if ([@"configureUserId" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *uId = args[@"uId"];
        if(uId == nil)
        {
            uId = @"";
        }
        [GameAnalytics configureUserId:uId];
    }
    else if ([@"initialize" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *gameKey = args[@"gameKey"];
        NSString *secretKey = args[@"secretKey"];
        if(gameKey == nil)
        {
            gameKey = @"";
        }
        if(secretKey == nil)
        {
            secretKey = @"";
        }
        NSString* sdkVersion = [NSString stringWithFormat:@"flutter %@", VERSION];

        [GameAnalytics configureSdkVersion:sdkVersion];
        [GameAnalytics initializeWithGameKey:gameKey gameSecret:secretKey];
    }
    else if ([@"addBusinessEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *currency = args[@"currency"];
        NSInteger amount = [args[@"amount"] intValue];
        NSString *itemType = args[@"itemType"];
        NSString *itemId = args[@"itemId"];
        NSString *cartType = args[@"cartType"];
        NSString* receipt = args[@"receipt"];
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        if(receipt == nil)
        {
            [GameAnalytics addBusinessEventWithCurrency:currency amount:amount itemType:itemType itemId:itemId cartType:cartType autoFetchReceipt:YES customFields:fields_dict mergeFields:mergeFields];
        }
        else
        {
            [GameAnalytics addBusinessEventWithCurrency:currency amount:amount itemType:itemType itemId:itemId cartType:cartType receipt:receipt customFields:fields_dict mergeFields:mergeFields];
        }
    }
    else if ([@"addResourceEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSInteger flowType = [args[@"flowType"] intValue];
        NSString *currency = args[@"currency"];
        NSNumber *amount = args[@"amount"];
        NSString *itemType = args[@"itemType"];
        NSString *itemId = args[@"itemId"];
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        [GameAnalytics addResourceEventWithFlowType:(GAResourceFlowType)flowType currency:currency amount:amount itemType:itemType itemId:itemId customFields:fields_dict mergeFields:mergeFields];
    }
    else if ([@"addProgressionEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;

        NSInteger progressionStatus = [args[@"progressionStatus"] intValue];
        NSString* progression01 = args[@"progression01"];
        NSString* progression02 = args[@"progression02"];
        NSString* progression03 = args[@"progression03"];
        NSInteger score = 0;
        BOOL sendScore = NO;
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        if(args[@"score"])
        {
            score = [args[@"score"] intValue];
            sendScore = YES;
        }

        if(sendScore)
        {
            [GameAnalytics addProgressionEventWithProgressionStatus:(GAProgressionStatus)progressionStatus progression01:progression01 progression02:progression02 progression03:progression03 score:score customFields:fields_dict mergeFields:mergeFields];
        }
        else
        {
            [GameAnalytics addProgressionEventWithProgressionStatus:(GAProgressionStatus)progressionStatus progression01:progression01 progression02:progression02 progression03:progression03 customFields:fields_dict mergeFields:mergeFields];
        }
    }
    else if ([@"addDesignEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;

        NSString* eventId = args[@"eventId"];
        NSNumber* value = nil;
        BOOL sendValue = NO;
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        if(args[@"value"])
        {
            value = args[@"value"];
            sendValue = YES;
        }

        if(sendValue)
        {
            [GameAnalytics addDesignEventWithEventId:eventId value:value customFields:fields_dict mergeFields:mergeFields];
        }
        else
        {
            [GameAnalytics addDesignEventWithEventId:eventId customFields:fields_dict mergeFields:mergeFields];
        }
    }
    else if ([@"addErrorEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;

        NSInteger severity = [args[@"severity"] intValue];
        NSString* message = args[@"message"];
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        [GameAnalytics addErrorEventWithSeverity:(GAErrorSeverity)severity message:message customFields:fields_dict mergeFields:mergeFields];
    }
    else if ([@"addAdEvent" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;

        NSInteger adAction = [args[@"adAction"] intValue];
        NSInteger adType = [args[@"adType"] intValue];
        NSString* adSdkName = args[@"adSdkName"];
        NSString* adPlacement = args[@"adPlacement"];
        NSInteger duration = 0;
        BOOL sendDuration = NO;
        NSInteger noAdReason = 0;
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        BOOL mergeFields = NO;
        if (args[@"mergeFields"])
        {
            mergeFields = [args[@"mergeFields"] boolValue];
        }

        if(args != nil)
        {
            adAction = args[@"adAction"] && [args[@"adAction"] isKindOfClass:[NSNumber class]] ? [[args valueForKey:@"adAction"] intValue] : 0;
            adType = args[@"adType"] && [args[@"adType"] isKindOfClass:[NSNumber class]] ? [[args valueForKey:@"adType"] intValue] : 0;
            adSdkName = args[@"adSdkName"] && [args[@"adSdkName"] isKindOfClass:[NSString class]] ? args[@"adSdkName"] : @"";
            adPlacement = args[@"adPlacement"] && [args[@"adPlacement"] isKindOfClass:[NSString class]] ? args[@"adPlacement"] : @"";
            duration = args[@"duration"] && [args[@"duration"] isKindOfClass:[NSNumber class]] ? [[args valueForKey:@"duration"] intValue] : 0;
            sendDuration = args[@"duration"] && [args[@"duration"] isKindOfClass:[NSNumber class]] ? YES : NO;
            noAdReason = args[@"noAdReason"] && [args[@"noAdReason"] isKindOfClass:[NSNumber class]] ? [[args valueForKey:@"noAdReason"] intValue] : 0;
        }

        if(sendDuration)
        {
            [GameAnalytics addAdEventWithAction:(GAAdAction)adAction adType:(GAAdType)adType adSdkName:adSdkName adPlacement:adPlacement duration:duration customFields:fields_dict mergeFields:mergeFields];
        }
        else
        {
            [GameAnalytics addAdEventWithAction:(GAAdAction)adAction adType:(GAAdType)adType adSdkName:adSdkName adPlacement:adPlacement noAdReason:(GAAdError)noAdReason customFields:fields_dict mergeFields:mergeFields];
        }
    }
    else if ([@"setEnabledInfoLog" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        BOOL flag = [args[@"flag"] boolValue];
        [GameAnalytics setEnabledInfoLog:flag];
    }
    else if ([@"setEnabledVerboseLog" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        BOOL flag = [args[@"flag"] boolValue];
        [GameAnalytics setEnabledVerboseLog:flag];
    }
    else if ([@"setEnabledManualSessionHandling" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        BOOL flag = [args[@"flag"] boolValue];
        [GameAnalytics setEnabledManualSessionHandling:flag];
    }
    else if ([@"setEnabledEventSubmission" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        BOOL flag = [args[@"flag"] boolValue];
        [GameAnalytics setEnabledEventSubmission:flag];
    }
    else if ([@"setCustomDimension01" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *dimension = args[@"dimension"];
        if(dimension == nil)
        {
            dimension = @"";
        }
        [GameAnalytics setCustomDimension01:dimension];
    }
    else if ([@"setCustomDimension02" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *dimension = args[@"dimension"];
        if(dimension == nil)
        {
            dimension = @"";
        }
        [GameAnalytics setCustomDimension02:dimension];
    }
    else if ([@"setCustomDimension03" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString *dimension = args[@"dimension"];
        if(dimension == nil)
        {
            dimension = @"";
        }
        [GameAnalytics setCustomDimension03:dimension];
    }
    else if ([@"setGlobalCustomEventFields" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSDictionary *fields_dict = nil;
        if (args[@"customFields"])
        {
            fields_dict = [NSJSONSerialization JSONObjectWithData:[args[@"customFields"] dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        }
        [GameAnalytics setGlobalCustomEventFields:fields_dict];
    }
    else if ([@"startSession" isEqualToString:call.method])
    {
        [GameAnalytics startSession];
    }
    else if ([@"endSession" isEqualToString:call.method])
    {
        [GameAnalytics endSession];
    }
    else if ([@"getRemoteConfigsValueAsString" isEqualToString:call.method])
    {
        NSMutableDictionary* args = call.arguments;
        NSString* key = args[@"key"];
        NSString* defaultValue = @"";

        NSString* returnValue = nil;
        if(args[@"defaultValue"])
        {
            defaultValue = args[@"defaultValue"];
            returnValue = [GameAnalytics getRemoteConfigsValueAsString:key defaultValue:defaultValue];
        }
        else
        {
            returnValue = [GameAnalytics getRemoteConfigsValueAsString:key];
        }
        result(returnValue);
    }
    else if ([@"isRemoteConfigsReady" isEqualToString:call.method])
    {
        result(@([GameAnalytics isRemoteConfigsReady]));
    }
    else if ([@"getRemoteConfigsContentAsString" isEqualToString:call.method])
    {
        result([GameAnalytics getRemoteConfigsContentAsString]);
    }
    else if ([@"getRemoteConfigsContentAsString" isEqualToString:call.method])
    {
        result([GameAnalytics getRemoteConfigsContentAsString]);
    }
    else if ([@"getABTestingId" isEqualToString:call.method])
    {
        result([GameAnalytics getABTestingId]);
    }
    else if ([@"getABTestingVariantId" isEqualToString:call.method])
    {
        result([GameAnalytics getABTestingVariantId]);
    }
    else
    {
        result(FlutterMethodNotImplemented);
    }
}

@end
