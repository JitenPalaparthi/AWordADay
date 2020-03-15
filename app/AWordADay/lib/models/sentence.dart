class Sentence {
  String id;
  String wordId;
  String sentence;
  String status;
  String lastUpdated;
  String updatedBy;

  Sentence({
    this.id,
    this.wordId,
    this.sentence,
    this.status,
    this.updatedBy,
    this.lastUpdated,
  });

  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
        id: json['id'],
        wordId: json['wordId'],
        sentence: json['sentence'],
        status: json['status'],
        updatedBy: json['updatedBy'],
        lastUpdated: json['lastUpdated']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["wordId"] = wordId;
    map["sentence"] = sentence;
    map["status"] = status;
    map["updatedBy"] = updatedBy;
    map["lastUpdated"] = lastUpdated;
    return map;
  }

   Map<String, dynamic> toJson() =>
      {"wordId": wordId, "sentence": sentence, "status": status,"updatedBy":updatedBy,"lastUpdated":lastUpdated};
}
