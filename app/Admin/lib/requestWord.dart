import 'package:Admin/models/requestWord.dart' as requestWord_model;
import 'package:flutter/material.dart';
import 'package:Admin/api/word.dart' as api_word;


class RequestWord extends StatefulWidget {
  

  // In the constructor, require a Todo.
  RequestWord({
    Key key,
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
      appBar: AppBar(title: Text("Request for a word")),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
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
          )),
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
