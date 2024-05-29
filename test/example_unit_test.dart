import 'package:bitcoin_calculator/util/conversions.dart';
import 'package:test/test.dart';

void main() {
  test('2 plus 2 is 4', () {
    int result = 2 + 2;
    expect(result, 4);
  });
  group('bitcoin to dollars', () {
    test('1 bitcoin converts to 20648usd', () {
      var bitcoinAmt = 1.0;
      var rateTest = 20648.0;
      var dollarAmt = Conversions.bitToDollars(bitcoinAmt, rateTest);
      expect(dollarAmt, 20648.0);
    });
    test('multiple bitcoin converts to correct amount', () {
      var bitcoinAmt = 5.0;
      var rate = 21650.75;
      var dollarAmt = Conversions.bitToDollars(bitcoinAmt, rate);
      expect(dollarAmt, 108253.75);
    });
    test('Negative input throws argument error', () {
      var bitcoinAmt = -1.0;
      var rateTest = 34553.53345;
      expect(() => Conversions.bitToDollars(bitcoinAmt, rateTest),
          throwsArgumentError);
    });
  });
  group('dollars to bitcoin', () {
    test('20648 dollars to 1 bitcoin', () {
      var dollarAmt = 20648.0;
      var rateTest = 20648.0;
      var bitcoinAmt = Conversions.dollarsToBit(dollarAmt, rateTest);
      expect(bitcoinAmt, 1.0);
    });
    test('bigger amount of usd converts to correct amount of bitcoin', () {
      var dollarAmt = 116725.0;
      var rateTest = 23345.0;
      var bitcoinAmt = Conversions.dollarsToBit(dollarAmt, rateTest);
      expect(bitcoinAmt, 5);
    });
    test('Negative input throws argument error', () {
      var dollarAmt = -1.0;
      var rateTest = 234234.0;
      expect(() => Conversions.dollarsToBit(dollarAmt, rateTest),
          throwsArgumentError);
    });
  });
}
