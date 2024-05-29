import 'package:bitcoin_calculator/screens/conversionscreen.dart';
import 'package:bitcoin_calculator/util/bitcoinAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config/globals.dart';

class startingScreen extends StatefulWidget {
  startingScreen();
  @override
  _startingScreenState createState() => _startingScreenState();
}

class _startingScreenState extends State<startingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: Key('usd-to-btc-button'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => conversionScreen('USDtoBTC')));
              },
              child: Text(
                'USD to BTC',
                style: TextStyle(color: Colors.white),
                key: Key('usd-btc-btn-text'),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
            Padding(padding: EdgeInsets.all(5)),
            ElevatedButton(
              key: Key('btc-to-usd-button'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => conversionScreen('BTCtoUSD')));
              },
              child: Text(
                'BTC to USD',
                style: TextStyle(color: Colors.white),
                key: Key('btc-usd-btn-text'),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
