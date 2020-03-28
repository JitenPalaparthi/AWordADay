import 'package:flutter/material.dart';
import 'package:AWordADay/home.dart';
import 'package:AWordADay/suggestWord.dart';
import 'package:AWordADay/requestWord.dart';
import 'package:AWordADay/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // In the constructor, require a Todo.
  MyApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final mainKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  setActiveTabWithMessage(int index, String message) {
    //_tabIndex = _tabController.index - 1;
    _tabController.animateTo(index);
    mainKey.currentState.showSnackBar(new SnackBar(
        content: Text(message), duration: Duration(milliseconds: 2000)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'A Word A Day',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blueGrey,

          brightness: Brightness.light,
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.blueGrey[300],

          // Define the default font family.
          //fontFamily: 'learning_curve',
        ),
        home: new Scaffold(
          key: mainKey,
          resizeToAvoidBottomInset: false,
          body: TabBarView(
            controller: _tabController,
            children: [
              new MyHomePage(title: "A Word A Day"),
              new SuggestAWord(
                title: "A Word A Day",
                notifyParent: setActiveTabWithMessage,
              ),
              new RequestWord(
                title: "A Word A Day",
                notifyParent: setActiveTabWithMessage,
              ),
              new About(),
            ],
          ),
          bottomNavigationBar: Container(
            child: new TabBar(
              controller: _tabController,

              tabs: [
                Tab(
                  icon: new Icon(
                    Icons.queue,
                    size: 30,
                  ),
                  text: "Word",
                ),
                Tab(
                    icon: new Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
                    text: "Suggest"),
                Tab(
                  icon: new Icon(Icons.note_add, size: 30),
                  text: "Request",
                ),
                Tab(icon: new Icon(Icons.info, size: 30), text: "About"),
              ],
              //labelColor: Colors.yellow,
              //unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(10.0),
              //indicatorColor: Colors.red,
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          backgroundColor: Colors.blueGrey[500],
        ));
  }

  Widget suggestAWord() {
    String _email, _word, _meaning, _type, _sentence1, _sentence2, _sentence3;
    return SingleChildScrollView(
        child: Form(
      //  key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Your Email:",
            ),
            validator: (str) =>
                !str.contains('@') ? "Not a Valid Email!" : null,
            onSaved: (str) => _email = str,
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Word:",
            ),
            validator: (str) => str.length <= 2 ? "Not a Valid word!" : null,
            onSaved: (str) => _word = str,
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Meaning:",
            ),
            validator: (str) => str.length <= 5 ? "Not a Valid Meaning!" : null,
            onSaved: (str) => _meaning = str,
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Type:",
            ),
            validator: (str) => str.length <= 2 ? "Not a Valid Type!" : null,
            onSaved: (str) => _type = str,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: "1.Sentence:",
            ),
            validator: (str) =>
                str.length <= 7 ? "Not a Valid Sentence!" : null,
            onSaved: (str) => _sentence1 = str,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: "2.Sentence:",
            ),
            validator: (str) =>
                str.length <= 7 ? "Not a Valid Sentence!" : null,
            onSaved: (str) => _sentence2 = str,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: "3.Sentence:",
            ),
            validator: (str) =>
                str.length <= 7 ? "Not a Valid Sentence!" : null,
            onSaved: (str) => _sentence3 = str,
          ),
        ],
      ),
    ));
  }
}
