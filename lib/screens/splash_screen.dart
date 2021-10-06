import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quote_app/constants.dart';
import 'package:quote_app/models/random_quote_model.dart';
import 'package:quote_app/resources/strings.dart';
import 'package:quote_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<RandomQuote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchData();
  }

  // ignore: missing_return
  Future<RandomQuote> fetchData() async {
    var uri = Uri.parse(RANDOM_QUOTE);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen())));

        return RandomQuote.fromJson(json);
      } else if (response.statusCode == 500) {
        print(response.body);
        Fluttertoast.showToast(
            msg: "Something went wrong, please try after some time");

        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong, please try after some time");

        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.4,
            // width: 100,
          ),
          SizedBox(
            height: size.height * 0.1,
            // width: double.infinity,
            child: Text(
              Strings.appName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              height: size.height * 0.15,
              child: FutureBuilder<RandomQuote>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                        child: SizedBox(
                            width: 250,
                            child: Text(
                              snapshot.data.content,
                              textAlign: TextAlign.center,
                            )));
                  } else if (snapshot.hasError) {
                    return Center(
                        child: SizedBox(
                            width: 250,
                            child: Text(
                              '${snapshot.error}',
                              textAlign: TextAlign.center,
                            )));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              )),
          SizedBox(
            height: size.height * 0.35,
            // width: double.infinity,
          ),
        ],
      ),
    );
  }
}
