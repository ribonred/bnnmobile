class Tersangka {
  int id;
  String lkn;

  Tersangka({this.id, this.lkn});

  factory Tersangka.fromJson(Map<String, dynamic> parsedJson) {
    return  Tersangka(
      id: parsedJson["id"],
      lkn: parsedJson["LKN"] as String
    );
  }
}