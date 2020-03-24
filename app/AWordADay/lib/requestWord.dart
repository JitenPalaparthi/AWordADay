import 'package:AWordADay/models/requestWord.dart' as requestWord_model;
import 'package:flutter/material.dart';
import 'package:AWordADay/api/word.dart' as api_word;


class RequestWord extends StatefulWidget {
  final String userType, userCategory;

  // In the constructor, require a Todo.
  RequestWord({
    Key key,
    this.userCategory,
    this.userType,
  }) : super(key: key);

  @override
  RequestWordState createState() => RequestWordState();
}

class RequestWordState extends State<RequestWord> {
  bool loggedIn = false;
  String _email, _word;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Request for a word")),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child:SingleChildScrollView(child:Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Email:",
                  ),
                  validator: (str) =>
                      !str.contains('@') ? "Not a Valid Email!" : null,
                  onSaved: (str) => _email = str,
                ),
                
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Request Word:",
                  ),
                  validator: (str) =>
                      str.length <= 2 ? "Not a Valid word!" : null,
                  onSaved: (str) => _word = str,
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
      requestWord_model.RequestWord objword = new requestWord_model.RequestWord(
        word: _word,
        status: "InActive",
        requestedBy: _email,
      );
      var result = await api_word.Word().requestAWord("", objword) ??
          null;
      if (result.status == "success") {
        Navigator.pop(context, true);
      } else {
        Navigator.pop(context, false);
      }
    }
  }
}
