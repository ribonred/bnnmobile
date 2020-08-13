class Lkn {
  int id;
  String lkn;

  Lkn({this.id, this.lkn});

  factory Lkn.fromJson(Map<String, dynamic> parsedJson) {
    return  Lkn(
      id: parsedJson["id"],
      lkn: parsedJson["LKN"] as String
    );
  }
}