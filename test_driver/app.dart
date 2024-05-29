import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/screens/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  final MockClient client = MockClient();
  final fakeRateAPIData =
      '{"time":{"updated":"Nov 7, 2022 03:29:00 UTC","updatedISO":"2022-11-07T03:29:00+00:00","updateduk":"Nov 7, 2022 at 03:29 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"20,912.5797","description":"United States Dollar","rate_float":20912.57}}}';
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
  when(client.get(url))
      .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));
  globals.httpClient = client;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
