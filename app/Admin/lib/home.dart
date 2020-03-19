import 'package:Admin/wordsGridView.dart';

import 'package:flutter/material.dart';
import 'package:Admin/models/word.dart';
import 'package:Admin/api/word.dart' as api_word;
import 'package:Admin/requestWord.dart';
import 'package:Admin/suggestWord.dart';
import 'models/word.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  bool isloading = false;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Word _word;
  final mainKey = GlobalKey<ScaffoldState>();

  Future<List<Word>> fetchAllFromServer(int skip, limit) async {
    return await api_word.Word().getWords(skip, limit).catchError((e) {
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _onTap(int index) {
    if (index == 0) {
      // getInit();
    }
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
            setState(() {});
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
        setState(() {});
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                fontFamily: 'learning_curve',
                fontWeight: FontWeight.bold,
                fontSize: 35)),
      ),
      body: Center(
        child: FutureBuilder<List<Word>>(
          future: fetchAllFromServer(0, 1000),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? buildAgain(context,
                    snapshot.data) //new WordGridView(words: snapshot.data)
                : new Center(child: new CircularProgressIndicator());
          },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container getStructuredGridCell(BuildContext context, Word word) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: getContainer("Word:", 15, FontWeight.normal)),
                  Expanded(
                      child: getContainer(word.word, 15, FontWeight.normal)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: getContainer("Meaning:", 15, FontWeight.normal)),
                  Expanded(
                    child: getContainer(word.meaning, 15, FontWeight.normal),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: getContainer("Word Type:", 15, FontWeight.normal)),
                  Expanded(
                    child: getContainer(word.type, 15, FontWeight.normal),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: getContainer("Status:", 15, FontWeight.normal)),
                  Expanded(
                      child: getContainer(word.status, 15, FontWeight.normal)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child:
                          getContainer("Sentence-1:", 15, FontWeight.normal)),
                  Expanded(
                      child: getContainer(
                          word.sentences[0].sentence, 15, FontWeight.normal)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child:
                          getContainer("Sentence-2:", 15, FontWeight.normal)),
                  Expanded(
                      child: getContainer(
                          word.sentences[1].sentence, 15, FontWeight.normal)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child:
                          getContainer("Sentence-3:", 15, FontWeight.normal)),
                  Expanded(
                      child: getContainer(
                          word.sentences[2].sentence, 15, FontWeight.normal)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  new RaisedButton(
                      child: word.status == "Active"
                          ? new Text("InActivate")
                          : new Text("Active"),
                      onPressed: () {
                        onChangeStatus(word.id,
                            word.status == "Active" ? "Inactivate" : "Active");
                      }),
                  new RaisedButton(
                      child: Text("Delete"),
                      onPressed: () {
                        onDelete(word.word);
                      }),
                ],
              ),
            ],
          ),
        )
      ],
    ));
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

  Widget buildAgain(BuildContext context, List<Word> words) {
    var _mediaQueryData = MediaQuery.of(context);
    //
    if (_mediaQueryData.size.width <= 355.0) {
      return new GridView.count(
        primary: false,
        crossAxisCount: 1,
        childAspectRatio: .25,
        children: List.generate(words.length, (index) {
          return getStructuredGridCell(context, words[index]);
        }),
      );
    } else {
      return new GridView.count(
        primary: true,
        crossAxisCount: 1,
        childAspectRatio: 2,
        children: List.generate(words.length, (index) {
          return getStructuredGridCell(context, words[index]);
        }),
      );
    }
  }

  void onDelete(String word) async {
    var result = await api_word.Word().deleteWord("", word) ?? null;
    if (result.status == "success") {
      setState(() {});
      mainKey.currentState.showSnackBar(new SnackBar(
          content: Text("Word successfully deleted"),
          duration: Duration(milliseconds: 5000)));
    } else {
      mainKey.currentState.showSnackBar(new SnackBar(
          content: Text("Word could not be deleted"),
          duration: Duration(milliseconds: 5000)));
    }
  }

  void onChangeStatus(String id, status) async {
    Map<String, dynamic> stausMap = new Map();
    stausMap["status"] = status;
    var result = await api_word.Word().updateWord("", id, stausMap) ?? null;
    if (result.status == "success") {
      setState(() {});
      mainKey.currentState.showSnackBar(new SnackBar(
          content: Text("Word status successfully updated"),
          duration: Duration(milliseconds: 5000)));
    } else {
      mainKey.currentState.showSnackBar(new SnackBar(
          content: Text("Word status could not be updated"),
          duration: Duration(milliseconds: 5000)));
    }
  }
}
// Only once fetch the record
