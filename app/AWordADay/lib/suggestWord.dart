import 'package:AWordADay/models/sentence.dart';
import 'package:AWordADay/models/word.dart';
import 'package:flutter/material.dart';
import 'package:AWordADay/api/word.dart' as api_word;

class SuggestAWord extends StatefulWidget {
  final String title;
  final Function(int index, String message) notifyParent;
  // In the constructor, require a Todo.
  SuggestAWord({Key key, this.title, @required this.notifyParent})
      : super(key: key);

  @override
  SuggestAWordState createState() => SuggestAWordState();
}

class SuggestAWordState extends State<SuggestAWord> {
  bool loggedIn = false;
  String _email, _word, _meaning, _type, _sentence1, _sentence2, _sentence3;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                fontFamily: 'learning_curve',
                fontWeight: FontWeight.bold,
                fontSize: 35)),
      ),
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: SingleChildScrollView(
              child: Form(
            key: formKey,
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
                  validator: (str) =>
                      str.length <= 2 ? "Not a Valid word!" : null,
                  onSaved: (str) => _word = str,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Meaning:",
                  ),
                  validator: (str) =>
                      str.length <= 5 ? "Not a Valid Meaning!" : null,
                  onSaved: (str) => _meaning = str,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Type:",
                  ),
                  validator: (str) =>
                      str.length <= 2 ? "Not a Valid Type!" : null,
                  onSaved: (str) => _type = str,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "1.Sentence:",
                  ),
                  validator: (str) =>
                      str.length <= 7 ? "Not a Valid Sentence!" : null,
                  onSaved: (str) => _sentence1 = str,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "2.Sentence:",
                  ),
                  validator: (str) =>
                      str.length <= 7 ? "Not a Valid Sentence!" : null,
                  onSaved: (str) => _sentence2 = str,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "3.Sentence:",
                  ),
                  validator: (str) =>
                      str.length <= 7 ? "Not a Valid Sentence!" : null,
                  onSaved: (str) => _sentence3 = str,
                ),
              ],
            ),
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: onSubmit,
      ),
    );
  }

  void onSubmit() async {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      List<Sentence> _sentences = new List<Sentence>();
      _sentences.add(new Sentence(
          sentence: _sentence1, updatedBy: _email, status: "InActive"));
      _sentences.add(new Sentence(
          sentence: _sentence2, updatedBy: _email, status: "InActive"));
      _sentences.add(new Sentence(
          sentence: _sentence3, updatedBy: _email, status: "InActive"));

      Word objword = new Word(
        word: _word,
        meaning: _meaning,
        type: _type,
        status: "InActive",
        updatedBy: _email,
        sentences: _sentences,
      );
      var result = await api_word.Word().addWord("", objword) ?? null;
      if (result.status == "success") {
        form.reset();
        widget.notifyParent(0, "Word successfully Suggested");
      } else {
        form.reset();
        widget.notifyParent(
            0, "Word  could not be suggested.Probably already existed.");
      }
    }
  }
}
