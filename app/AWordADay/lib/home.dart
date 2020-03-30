import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:AWordADay/models/word.dart';
import 'package:AWordADay/api/word.dart' as api_word;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

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
    Word storedWord;
    final prefs = await SharedPreferences.getInstance();
    final day = prefs.getInt('fetchOn') ?? 0;
    if (day == DateTime.now().day) {
      storedWord = await fetchFromLocal();

      await setWordState(storedWord);
    }
    if (storedWord == null || day != DateTime.now().day) {
      Word item = await fetchFromServer();

      if (item != null) {
        storeInLocal(item);
        setWordState(item);
      } else {
        storedWord = await fetchFromLocal();
        setWordState(storedWord);
      }
    }
  }

  setWordState(Word item) async {
    if (item != null) {
      setState(() {
        _word = item;
        isLoaded = true;
      });
    }
  }

  void getInitPlatform() async {
    var item = await api_word.Word().getMagicWord();
    print(item.meaning);
    if (item != null) {
      setState(() {
        _word = item;
        isLoaded = true;
      });
    }
  }

  Future<Word> fetchFromServer() async {
    return await api_word.Word().getMagicWord().catchError((e) {
      return null;
    });
  }

  Future<Word> fetchFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var storedWordStr = prefs.getString('storedWord') ?? null;
    if (storedWordStr != null) {
      var storedWordStr2 = json.decode(storedWordStr) ?? null;

      if (storedWordStr2 != null) {
        return Word.fromJson(storedWordStr2) ?? null;
      }
    }
    return null;
  }

  void storeInLocal(Word item) async {
    if (item != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('storedWord', json.encode(item));
      var day = new DateTime.now().day;
      prefs.setInt('fetchOn', day);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getInit();
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
      body: 
        SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generateWordFrame(_word),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: (){
           final RenderBox box = context.findRenderObject();
                             Share.share("Hello Muruga",
                                  subject: "Muruga Share",
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
        },
      ),
      //ing comma makes auto-formatting nicer for build methods.
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

}
// Only once fetch the record
