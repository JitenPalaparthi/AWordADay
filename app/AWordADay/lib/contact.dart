import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
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
      body: new Container(
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
                              text: 'Contact me on',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      new SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Icon(Icons.email),
                            new RichText(
                                text: TextSpan(
                                    text: 'JitenP@Outlook.Com',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18))),
                          ]),
                      new SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Icon(Icons.phone),
                            new RichText(
                                text: TextSpan(
                                    text: '+91-9619559500',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18))),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
