import 'package:flutter/material.dart';

class About extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A Word A Day",
            style: TextStyle(
                fontFamily: 'learning_curve',
                fontWeight: FontWeight.bold,
                fontSize: 35)),
      ),
      body:SingleChildScrollView(child: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Column(
                    children: <Widget>[
                      new RichText(
                          text: TextSpan(
                              text: '"A Word A Day" is a very simple yet useful application.' +
                                  'Our main intention is to improve your vocabulary but not in hurry.' +
                                  'Just learn a single word each day and gradually improve your English vocabulary.' +
                                  'Application shows only one word per day . The word will be changed only upon the day changes.Enjoy Learning...',
                              style: TextStyle(color: Colors.black,fontSize: 18))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
