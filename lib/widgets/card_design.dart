import 'package:flutter/material.dart';
import 'package:quote_app/screens/quote_detail_screen.dart';

class CardDesign extends StatelessWidget {
  final quote;

  const CardDesign({
    Key key,
    this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote['content'],
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(quote['author'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ],
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuoteDetail(
                            author: quote['author'],
                            content: quote['content'],
                          ),
                        ));
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)))
        ],
      ),
    );
  }
}
