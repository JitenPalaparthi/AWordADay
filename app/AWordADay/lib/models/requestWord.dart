class RequestWord {
  String id;
  String word;
  String status;
  String lastUpdated;
  String requestedBy;

  RequestWord({
    this.id,
    this.word,
    this.status,
    this.requestedBy,
    this.lastUpdated,
  });

  factory RequestWord.fromJson(Map<String, dynamic> json) {
    return RequestWord(
        id: json['id'],
        word: json['word'],
        status: json['status'],
        requestedBy: json['requestedBy'],
        lastUpdated: json['lastUpdated']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["word"] = word;
    map["status"] = status;
    map["requestedBy"] = requestedBy;
    map["lastUpdated"] = lastUpdated;
    return map;
  }

   Map<String, dynamic> toJson() =>
      {"word": word,  "status": status,"requestedBy":requestedBy,"lastUpdated":lastUpdated};
}
