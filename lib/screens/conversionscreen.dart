import 'package:bitcoin_calculator/screens/startingscreen.dart';
import 'package:bitcoin_calculator/util/bitcoinAPI.dart';
import 'package:bitcoin_calculator/util/conversions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config/globals.dart';

class conversionScreen extends StatefulWidget {
  String convertType;
  conversionScreen(this.convertType);
  @override
  _conversionScreenState createState() => _conversionScreenState();
}

class _conversionScreenState extends State<conversionScreen> {
  TextEditingController inputTextEditor = new TextEditingController();
  bool isInvalid = false;
  String result = '';
  double rate = 0;
  bool checkInputUSD(String s) {
    if (s.contains(new RegExp(r'^[0-9]*\.[0-9]{2}$'))) {
      return true;
    } else {
      return false;
    }
  }

  bool checkInputBit(String s) {
    if (s.isEmpty || s == null) {
      return false;
    }
    if (s.contains(new RegExp(r'^(([0-9]*)|(([0-9]*)\.([0-9]*)))$'))) {
      return true;
    } else {
      return false;
    }
  }

  Future<double> futureBitcoin;
  @override
  void initState() {
    super.initState();
    futureBitcoin = BitcoinAmountAPI.fetchBitcoinAmount(httpClient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 48.0,
            width: 337.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: result.isEmpty ? Colors.white : Colors.green[100],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                    color: result.isEmpty ? Colors.white : Colors.green,
                    width: 1.75),
              ),
              child: Text(
                'Amount in ${widget.convertType == 'USDtoBTC' ? 'Bitcoin' : 'Dollars'}: $result',
                key: Key('result-text'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: result.isEmpty ? Colors.white : Colors.green[900],
                    fontSize: 20),
              ),
            ),
          ),
          TextField(
              controller: inputTextEditor,
              textAlign: TextAlign.center,
              key: Key('input-textfield'),
              decoration: InputDecoration(
                  labelText: widget.convertType == 'USDtoBTC'
                      ? 'Enter USD here'
                      : 'Enter BTC here')),
          Padding(padding: EdgeInsets.all(5)),
          Container(
            height: 48.0,
            width: 337.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: isInvalid ? Colors.red[100] : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                    color: isInvalid ? Colors.red : Colors.white, width: 1.75),
              ),
              child: Text(
                isInvalid ? 'Invalid Input' : '',
                key: Key('invalid-text'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isInvalid ? Colors.red[900] : Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          FutureBuilder<double>(
              future: futureBitcoin,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  rate = snapshot.data;
                  return ElevatedButton(
                    key: Key('convert-to-btn'),
                    onPressed: () {
                      if (widget.convertType == 'USDtoBTC') {
                        if (checkInputUSD(inputTextEditor.text)) {
                          isInvalid = false;
                          result = widget.convertType == 'USDtoBTC'
                              ? Conversions.dollarsToBit(
                                      double.parse(inputTextEditor.text), rate)
                                  .toString()
                              : Conversions.bitToDollars(
                                      double.parse(inputTextEditor.text), rate)
                                  .toString();
                        } else {
                          isInvalid = true;
                          result = "";
                        }
                      } else {
                        if (checkInputBit(inputTextEditor.text)) {
                          isInvalid = false;
                          result = widget.convertType == 'USDtoBTC'
                              ? Conversions.dollarsToBit(
                                      double.parse(inputTextEditor.text), rate)
                                  .toString()
                              : Conversions.bitToDollars(
                                      double.parse(inputTextEditor.text), rate)
                                  .toString();
                        } else {
                          isInvalid = true;
                          result = "";
                        }
                      }
                      setState(() {});
                    },
                    child: Text(
                      widget.convertType == 'USDtoBTC'
                          ? 'Convert to BTC'
                          : 'Convert to USD',
                      style: TextStyle(color: Colors.white),
                      key: Key('convert-to-btn-text'),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  );
                } else if (snapshot.hasError) {
                  return ElevatedButton(
                    key: Key('convert-to-btn'),
                    onPressed: null,
                    child: Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                      key: Key('convert-to-btn-text'),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  );
                }
                return CircularProgressIndicator();
              }),
          Padding(padding: EdgeInsets.all(5)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => startingScreen()));
            },
            child: Text('Done'),
            key: Key('done-btn'),
          ),
        ]),
      ),
    );
  }
}
