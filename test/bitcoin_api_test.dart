import 'package:bitcoin_calculator/util/bitcoinAPI.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

main() {
  test('returns a string if the http call completes successfully', () async {
    final client = MockClient();
    final fakeBitcoinAPIData =
        '{"time":{"updated":"Nov 7, 2022 03:29:00 UTC","updatedISO":"2022-11-07T03:29:00+00:00","updateduk":"Nov 7, 2022 at 03:29 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"20,912.5797","description":"United States Dollar","rate_float":20912.5797}}}';
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    when(client.get(url))
        .thenAnswer((_) async => http.Response(fakeBitcoinAPIData, 200));
    double amt = await BitcoinAmountAPI.fetchBitcoinAmount(client);
    expect(amt, isA<double>());
    expect(amt, 20912.5797);
  });
  test('Throws an exception if the http call completes with an error', () {
    final client = MockClient();
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    when(client.get(url))
        .thenAnswer((_) async => http.Response('Not Found', 404));
    expect(BitcoinAmountAPI.fetchBitcoinAmount(client), throwsException);
  });
}
