import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameanalytics_sdk/gameanalytics.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('gameanalytics');
  final binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    binaryMessenger.setMockMethodCallHandler(channel, (methodCall) async {
      calls.add(methodCall);

      switch (methodCall.method) {
        case 'isRemoteConfigsReady':
          return true;
        case 'getRemoteConfigsValueAsString':
          return 'remote-value';
        case 'getRemoteConfigsContentAsString':
          return '{"debug_menu":"enabled"}';
        case 'getABTestingId':
          return 'experiment-id';
        case 'getABTestingVariantId':
          return 'variant-id';
      }

      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(channel, null);
  });

  group('GameAnalytics Dart API', () {
    test('forwards initialization and logging calls', () async {
      await GameAnalytics.setEnabledInfoLog(true);
      await GameAnalytics.setEnabledVerboseLog(false);
      await GameAnalytics.configureAutoDetectAppVersion(true);
      await GameAnalytics.initialize('game-key', 'secret-key');

      expect(
        calls.map((call) => call.method),
        <String>[
          'setEnabledInfoLog',
          'setEnabledVerboseLog',
          'configureAutoDetectAppVersion',
          'initialize',
        ],
      );
      expect(calls[0].arguments, <String, Object>{'flag': true});
      expect(calls[1].arguments, <String, Object>{'flag': false});
      expect(calls[2].arguments, <String, Object>{'flag': true});
      expect(
        calls[3].arguments,
        <String, Object>{'gameKey': 'game-key', 'secretKey': 'secret-key'},
      );
    });

    test('forwards events and session calls', () async {
      await GameAnalytics.addDesignEvent(<String, Object>{
        'eventId': 'debug:testEvent',
        'value': 1,
      });
      await GameAnalytics.startSession();
      await GameAnalytics.endSession();

      expect(
        calls.map((call) => call.method),
        <String>['addDesignEvent', 'startSession', 'endSession'],
      );
      expect(
        calls.first.arguments,
        <String, Object>{'eventId': 'debug:testEvent', 'value': 1},
      );
    });

    test('forwards Remote Config reads', () async {
      expect(
        await GameAnalytics.getRemoteConfigsValueAsString(
          'debug_menu',
          'disabled',
        ),
        'remote-value',
      );
      expect(await GameAnalytics.isRemoteConfigsReady(), isTrue);
      expect(
        await GameAnalytics.getRemoteConfigsContentAsString(),
        '{"debug_menu":"enabled"}',
      );
      expect(await GameAnalytics.getABTestingId(), 'experiment-id');
      expect(await GameAnalytics.getABTestingVariantId(), 'variant-id');

      expect(
        calls.map((call) => call.method),
        <String>[
          'getRemoteConfigsValueAsString',
          'isRemoteConfigsReady',
          'getRemoteConfigsContentAsString',
          'getABTestingId',
          'getABTestingVariantId',
        ],
      );
      expect(
        calls.first.arguments,
        <String, Object>{
          'key': 'debug_menu',
          'defaultValue': 'disabled',
        },
      );
    });
  });

  group('native void MethodChannel replies', () {
    const voidMethods = <String>[
      'configureAvailableCustomDimensions01',
      'configureAvailableCustomDimensions02',
      'configureAvailableCustomDimensions03',
      'configureAvailableResourceCurrencies',
      'configureAvailableResourceItemTypes',
      'configureBuild',
      'configureAutoDetectAppVersion',
      'configureUserId',
      'initialize',
      'addBusinessEvent',
      'addResourceEvent',
      'addProgressionEvent',
      'addDesignEvent',
      'addErrorEvent',
      'addAdEvent',
      'setEnabledInfoLog',
      'setEnabledVerboseLog',
      'setEnabledManualSessionHandling',
      'setEnabledEventSubmission',
      'setCustomDimension01',
      'setCustomDimension02',
      'setCustomDimension03',
      'setGlobalCustomEventFields',
      'startSession',
      'endSession',
    ];

    test('iOS handlers reply after successful void calls', () {
      final source =
          File('ios/Classes/GameAnalyticsPlugin.m').readAsStringSync();

      for (final method in voidMethods) {
        final branch = _methodBranch(source, method, ios: true);
        expect(
          branch,
          contains('result(nil);'),
          reason: '$method must complete its FlutterResult on iOS.',
        );
        expect(
          _occurrences(branch, 'result(nil);'),
          1,
          reason:
              '$method must complete its FlutterResult exactly once on iOS.',
        );
      }
    });

    test('Android handlers reply after successful void calls', () {
      final source = File(
        'android/src/main/java/com/gameanalytics/sdk/flutter/'
        'GameAnalyticsPlugin.java',
      ).readAsStringSync();

      for (final method in voidMethods) {
        final branch = _methodBranch(source, method, ios: false);
        expect(
          branch,
          contains('result.success(null);'),
          reason: '$method must complete its Result on Android.',
        );
        expect(
          _occurrences(branch, 'result.success(null);'),
          1,
          reason: '$method must complete its Result exactly once on Android.',
        );
      }
    });
  });
}

String _methodBranch(String source, String method, {required bool ios}) {
  final marker = ios
      ? '[@\"$method\" isEqualToString:call.method]'
      : 'call.method.equals("$method")';
  final start = source.indexOf(marker);
  expect(start, isNonNegative, reason: '$method branch should exist.');

  final nextMarkers = ios
      ? <String>['\n    else if ([@\"', '\n    else\n']
      : <String>['\n        else if (call.method.equals("', '\n        else\n'];
  final nextIndexes = nextMarkers
      .map((nextMarker) => source.indexOf(nextMarker, start + marker.length))
      .where((index) => index >= 0)
      .toList()
    ..sort();
  final end = nextIndexes.isEmpty ? source.length : nextIndexes.first;

  return source.substring(start, end);
}

int _occurrences(String source, String pattern) {
  return pattern.allMatches(source).length;
}
