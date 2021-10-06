import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quote_app/resources/strings.dart';
import 'package:quote_app/widgets/card_design.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  bool nextPage = true;
  bool isFirstLoad = false;
  bool isLoadMore = false;
  List quotes = [];

  void _firstLoad() async {
    setState(() {
      isFirstLoad = true;
    });
    try {
      final res = await http.get(Uri.parse(API_BASE_URL + "quotes?page=$page"));
      final jsondata = json.decode(res.body);
      setState(() {
        quotes = jsondata['results'];
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      isFirstLoad = false;
    });
  }

  void _loadMore() async {
    if (nextPage == true &&
        isFirstLoad == false &&
        isLoadMore == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        isFirstLoad = true;
      });
      page = page + 1;
      try {
        final res =
            await http.get(Uri.parse(API_BASE_URL + "quotes?page=$page"));

        final jsondata = json.decode(res.body);

        if (jsondata['results'].length > 0) {
          setState(() {
            quotes.addAll(jsondata['results']);
          });
        } else {
          setState(() {
            nextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        isLoadMore = false;
      });
    }
  }

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Strings.appbartitle,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: isFirstLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: quotes.length,
                      itemBuilder: (_, index) => CardDesign(
                            quote: quotes[index],
                          )),
                ),
                if (isLoadMore == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (nextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.white,
                    child: Center(
                      child: Text('You have fetched all of the quotes'),
                    ),
                  ),
              ],
            ),
    );
  }
}
