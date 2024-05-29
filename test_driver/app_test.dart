// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Happy Paths', () {
    test('We should be able to convert USD to BTC', () async {
      final USDtoBTCBtnFinder = find.byValueKey('usd-to-btc-button');
      final USDtoBTCBtnText = find.byValueKey('usd-btc-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final resultText = find.byValueKey('result-text');
      final doneBtn = find.byValueKey('done-btn');
      expect(await driver.getText(USDtoBTCBtnText), 'USD to BTC');
      await driver.tap(USDtoBTCBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to BTC');

      await driver.tap(inputTextfield);
      await driver.enterText('20912.57');
      await driver.waitFor(find.text('20912.57'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(resultText), 'Amount in Bitcoin: 1.0');
      await driver.tap(doneBtn);
    });
    test('We should be able to convert BTC to USD', () async {
      final BTCtoUSDBtnFinder = find.byValueKey('btc-to-usd-button');
      final BTCtoUSDBtnText = find.byValueKey('btc-usd-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final resultText = find.byValueKey('result-text');
      final doneBtn = find.byValueKey('done-btn');
      expect(await driver.getText(BTCtoUSDBtnText), 'BTC to USD');
      await driver.tap(BTCtoUSDBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to USD');

      await driver.tap(inputTextfield);
      await driver.enterText('1.0');
      await driver.waitFor(find.text('1.0'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(resultText), 'Amount in Dollars: 20912.57');
      await driver.tap(doneBtn);
    });
  });
  group('Sad Paths', () {
    test('We should get an error if we enter an empty value USD to BTC',
        () async {
      final USDtoBTCBtnFinder = find.byValueKey('usd-to-btc-button');
      final USDtoBTCBtnText = find.byValueKey('usd-btc-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(USDtoBTCBtnText), 'USD to BTC');
      await driver.tap(USDtoBTCBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to BTC');

      await driver.tap(inputTextfield);
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });
    test('We should get an error if we enter a negative value USD to BTC',
        () async {
      final USDtoBTCBtnFinder = find.byValueKey('usd-to-btc-button');
      final USDtoBTCBtnText = find.byValueKey('usd-btc-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(USDtoBTCBtnText), 'USD to BTC');
      await driver.tap(USDtoBTCBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to BTC');

      await driver.tap(inputTextfield);
      await driver.enterText('-20648.00');
      await driver.waitFor(find.text('-20648.00'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });
    test('We should get an error if we enter a letter value USD to BTC',
        () async {
      final USDtoBTCBtnFinder = find.byValueKey('usd-to-btc-button');
      final USDtoBTCBtnText = find.byValueKey('usd-btc-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(USDtoBTCBtnText), 'USD to BTC');
      await driver.tap(USDtoBTCBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to BTC');

      await driver.tap(inputTextfield);
      await driver.enterText('a');
      await driver.waitFor(find.text('a'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });
    test('We should get an error if we enter an empty value BTC to USD',
        () async {
      final BTCtoUSDBtnFinder = find.byValueKey('btc-to-usd-button');
      final BTCtoUSDBtnText = find.byValueKey('btc-usd-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(BTCtoUSDBtnText), 'BTC to USD');
      await driver.tap(BTCtoUSDBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to USD');

      await driver.tap(inputTextfield);
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });

    test('We should get an error if we enter a negative value BTC to USD',
        () async {
      final BTCtoUSDBtnFinder = find.byValueKey('btc-to-usd-button');
      final BTCtoUSDBtnText = find.byValueKey('btc-usd-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(BTCtoUSDBtnText), 'BTC to USD');
      await driver.tap(BTCtoUSDBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to USD');

      await driver.tap(inputTextfield);
      await driver.enterText('-1.0');
      await driver.waitFor(find.text('-1.0'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });
    test('We should get an error if we enter a letter value BTC to USD',
        () async {
      final BTCtoUSDBtnFinder = find.byValueKey('btc-to-usd-button');
      final BTCtoUSDBtnText = find.byValueKey('btc-usd-btn-text');
      final ConvertToBtn = find.byValueKey('convert-to-btn');
      final ConvertToBtnText = find.byValueKey('convert-to-btn-text');
      final inputTextfield = find.byValueKey('input-textfield');
      final doneBtn = find.byValueKey('done-btn');
      final invalidText = find.byValueKey('invalid-text');
      expect(await driver.getText(BTCtoUSDBtnText), 'BTC to USD');
      await driver.tap(BTCtoUSDBtnFinder);
      expect(await driver.getText(ConvertToBtnText), 'Convert to USD');

      await driver.tap(inputTextfield);
      await driver.enterText('a');
      await driver.waitFor(find.text('a'));
      await driver.tap(ConvertToBtn);
      expect(await driver.getText(invalidText), 'Invalid Input');
      await driver.tap(doneBtn);
    });
  });
}
