class Penangkapan {
  int id;
  String lkn;
  String penangkapan;

  Penangkapan({this.id, this.lkn, this.penangkapan});

  factory Penangkapan.fromJson(Map<String, dynamic> parsedJson) {
    return Penangkapan(
      id: parsedJson["id"],
      penangkapan: parsedJson["no_penangkapan"] as String
    );
  }
}