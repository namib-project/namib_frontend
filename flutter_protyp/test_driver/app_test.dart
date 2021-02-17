import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Testing App Performance Tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Scrolling test', () async {
      final listFinder = find.byType('ListView');

      final scrollingTimeline = await driver.traceAction(() async {
        await driver.scroll(listFinder, 0, -7000, Duration(seconds: 1));
        await driver.scroll(listFinder, 0, 7000, Duration(seconds: 1));
      });

      final scrollingSummary = TimelineSummary.summarize(scrollingTimeline);
      await scrollingSummary.writeSummaryToFile('scrolling', pretty: true);
      await scrollingSummary.writeTimelineToFile('scrolling', pretty: true);
    });

    test('Favorites operations test', () async {
      final operationsTimeline = await driver.traceAction(() async {
        final iconKeys = [
          'icon_0',
          'icon_1',
          'icon_2',
        ];

        for (var icon in iconKeys) {
          await driver.tap(find.byValueKey(icon));
          await driver.waitFor(find.text('Added to favorites.'));
        }

        await driver.tap(find.text('Favorites'));

        final removeIconKeys = [
          'remove_icon_0',
          'remove_icon_1',
          'remove_icon_2',
        ];

        for (final iconKey in removeIconKeys) {
          await driver.tap(find.byValueKey(iconKey));
          await driver.waitFor(find.text('Removed from favorites.'));
        }
      });

      final operationsSummary = TimelineSummary.summarize(operationsTimeline);
      await operationsSummary.writeSummaryToFile('favorites_operations',
          pretty: true);
      await operationsSummary.writeTimelineToFile('favorites_operations',
          pretty: true);
    });
  });