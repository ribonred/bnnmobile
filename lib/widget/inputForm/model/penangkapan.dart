class Tersangka {
  int id;
  String lkn;
  String penangkapan;

  Tersangka({this.id, this.lkn, this.penangkapan});

  factory Tersangka.fromJson(Map<String, dynamic> parsedJson) {
    return  Tersangka(
      id: parsedJson["id"],
      lkn: parsedJson["lkn"] as String,
      penangkapan: parsedJson["no_penangkapan"] as String
    );
  }
}