import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Admin/api/word.dart' as api_word;

import 'models/word.dart';
class WordGridView extends StatefulWidget {
  final List<Word> words;
  WordGridView({Key key, this.words}) : super(key: key);

  @override
  WordGridViewState createState() => WordGridViewState();
}
class WordGridViewState extends State<WordGridView>  {
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
                        onChangeStatus(context, word.id,
                            word.status == "Active" ? "Inactivate" : "Active");
                      }),
                  new RaisedButton(
                      child: Text("Delete"),
                      onPressed: () {
                        onDelete(context, word.word);
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

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    //
    if (_mediaQueryData.size.width <= 355.0) {
      return new GridView.count(
        primary: false,
        crossAxisCount: 1,
        childAspectRatio: .25,
        children: List.generate(widget.words.length, (index) {
          return getStructuredGridCell(context, widget.words[index]);
        }),
      );
    } else {
      return new GridView.count(
        primary: true,
        crossAxisCount: 1,
        childAspectRatio: 2,
        children: List.generate(widget.words.length, (index) {
          return getStructuredGridCell(context, widget.words[index]);
        }),
      );
    }
  }

  void onDelete(BuildContext context, String word) async {
    var result = await api_word.Word().deleteWord("", word) ?? null;
    if (result.status == "success") {
      Scaffold.of(context).setState(() { });
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text("Word successfully deleted"),
          duration: Duration(milliseconds: 5000)));
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text("Word could not be deleted"),
          duration: Duration(milliseconds: 5000)));
    }
  }

  void onChangeStatus(BuildContext context, String id, status) async {
    Map<String, dynamic> stausMap = new Map();
    stausMap["status"] = status;
    var result = await api_word.Word().updateWord("", id, stausMap) ?? null;
    if (result.status == "success") {
     
      Scaffold.of(context).setState(() {  });
      // Scaffold.of(context).initState();
      
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text("Word status successfully updated"),
          duration: Duration(milliseconds: 5000)));
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text("Word status could not be updated"),
          duration: Duration(milliseconds: 5000)));
    }
  }
}
