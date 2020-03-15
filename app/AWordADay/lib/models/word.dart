import 'package:AWordADay/models/sentence.dart';

class Word {
  String id;
  String word;
  String meaning;
  String type;
  List<Sentence> sentences;
  String status;
  String lastUpdated;
  String updatedBy;

  Word({
    this.id,
    this.word,
    this.meaning,
    this.type,
    this.sentences,
    this.status,
    this.updatedBy,
    this.lastUpdated,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
     var list = json['sentences'] as List;
  
    List<Sentence> sentencesList = list.map((i) => Sentence.fromJson(i)).toList();
    return Word(
      id: json['id'],
      word: json['word'],
      meaning: json['meaning'],
      type: json['type'],
      sentences: sentencesList,
      status: json['status'],
      updatedBy: json['updatedBy'],
      lastUpdated: json['lastUpdated']
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["word"] = word;
    map["meaning"] = meaning;
    map["type"] = type;
    map["sentences"]=sentences;
    map["status"]=status;
    map["updatedBy"]=updatedBy;
    map["lastUpdated"]=lastUpdated;
    return map;
  }

   Map<String, dynamic> toJson() =>
      {"word": word, "meaning": meaning,"type":type,"sentences":sentences, "status": status,"updatedBy":updatedBy,"lastUpdated":lastUpdated};

}
