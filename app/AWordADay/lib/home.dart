import 'dart:convert';
import 'package:AWordADay/requestWord.dart';
import 'package:AWordADay/suggestWord.dart';
import 'package:AWordADay/about.dart';
import 'package:AWordADay/contact.dart';

import 'package:flutter/material.dart';
import 'package:AWordADay/models/word.dart';
import 'package:AWordADay/api/word.dart' as api_word;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Word _word;
  bool isLoaded;
  final mainKey = GlobalKey<ScaffoldState>();

  void getInit() async {
    dynamic storedWord;
    final prefs = await SharedPreferences.getInstance();
    final day = prefs.getInt('fetchOn') ?? 0;
    if (day == DateTime.now().day) {
      storedWord = json.decode(prefs.getString('storedWord')) ?? null;
      setState(() {
        _word = Word.fromJson(storedWord);
        isLoaded = true;
      });
    }
    if (storedWord == null || day != DateTime.now().day) {
      const url = "http://localhost:50051/v1/word/getMagicWord";
      var item = await api_word.Word().getMagicWord(url);
      if (item != null) {
        prefs.setString('storedWord', json.encode(item));
        var day = new DateTime.now().day;
        prefs.setInt('fetchOn', day);
        setState(() {
          _word = item;
          isLoaded = true;
        });
      } else {
        storedWord = json.decode(prefs.getString('storedWord')) ?? null;
        setState(() {
          _word = Word.fromJson(storedWord);
          isLoaded = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this.getInit();
  }

  _onTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RequestWord(),
        ),
      ).then((value) {
        if (value == null) {
          return;
        }
        if (value == true) {
          mainKey.currentState.showSnackBar(new SnackBar(
              content: Text("Word successfully requested"),
              duration: Duration(milliseconds: 1000)));
        } else {
          mainKey.currentState.showSnackBar(new SnackBar(
              content: Text(
                  "Word  could not be requested.Probably already existed."),
              duration: Duration(milliseconds: 1000)));
        }
        // Run the code here using the value
      });
    }
  }

  _onAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestAWord(),
      ),
    ).then((value) {
      if (value == null) {
        return;
      }
      if (value == true) {
        mainKey.currentState.showSnackBar(new SnackBar(
            content: Text("Word successfully suggested"),
            duration: Duration(milliseconds: 5000)));
      } else {
        mainKey.currentState.showSnackBar(new SnackBar(
            content:
                Text("Word  could not be suggested.Probably already existed."),
            duration: Duration(milliseconds: 5000)));
      }
      // Run the code here using the value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                fontFamily: 'learning_curve',
                fontWeight: FontWeight.bold,
                fontSize: 35)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generateWordFrame(_word),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), title: Text('Request'))
        ],
        onTap: _onTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        tooltip: 'Add a new Word ',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked,
          drawer: _drawer(context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> generateWordFrame(Word _word) {
    List<Widget> list = new List();
    if (_word != null) {
      list.add(getContainer(_word.word, 25, FontWeight.bold));
      list.add(getContainer("General Meaning", 15, FontWeight.normal));
      list.add(getContainer(_word.meaning, 20, FontWeight.normal));
      list.add(getContainer("Word Type of", 15, FontWeight.normal));
      list.add(getContainer(_word.type, 20, FontWeight.normal));
      list.add(getContainer("Few Sentences", 15, FontWeight.normal));
      _word.sentences.forEach((element) => list.add(getContainer(
          (_word.sentences.indexOf(element) + 1).toString() +
              ". " +
              element.sentence,
          20,
          FontWeight.normal)));
      return list;
    }
    list.add(Container());
    return list;
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Center(
                        child: Text(widget.title,
                            style: TextStyle(
                                fontFamily: 'learning_curve',
                                fontWeight: FontWeight.bold,
                                fontSize: 35)))),
                SizedBox(height: 5),
                Text('Hello User'),
                SizedBox(height: 5),
              ],
            ), //Text('Hello $name'),
            decoration: BoxDecoration(
              color: Colors.blueGrey[300],
            ),
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => About()));
            },
          ),
          ListTile(
            title: Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Contact()));
            },
          ),
          ListTile(
            title: Text('Share'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => RequestWord()));
            },
          ),
        ],
      ),
    );
  }
}

Widget getContainer(String text, double size, FontWeight weight) {
  return Container(
    child: new Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 68, 68, 68)),
    ),
    alignment: Alignment.centerLeft,
    margin: new EdgeInsets.all(10.0),
  );
}

// Only once fetch the record
