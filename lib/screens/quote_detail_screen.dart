import 'package:flutter/material.dart';
import 'package:quote_app/resources/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteDetail extends StatefulWidget {
  final String content;
  final String author;
  const QuoteDetail({Key key, this.author, this.content}) : super(key: key);

  @override
  _QuoteDetailState createState() => _QuoteDetailState();
}

class _QuoteDetailState extends State<QuoteDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: size.height * 0.3,
            ),
            SizedBox(
              width: 250,
              child: Text(
                widget.content,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 250,
              height: size.height * 0.05,
            ),
            SizedBox(
                width: 250,
                child: Text(
                  "By ${widget.author}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
            Spacer(),
            InkWell(
              onTap: () async {
                String msg = '''Quote : ${widget.content} 
Author : ${widget.author}''';

                openwhatsapp(msg);
              },
              child: Text(
                Strings.sharebuttontext,
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 15),
              ),
            ),
            SizedBox(
              width: 250,
              height: size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }

  openwhatsapp(msg) async {
    var whatsappURlAndroid = "whatsapp://send?&text=$msg";

    if (await canLaunch(whatsappURlAndroid)) {
      await launch(whatsappURlAndroid);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}
