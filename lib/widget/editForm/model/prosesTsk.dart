class ProsesTSK {
  int id;
  String spHan;
  String tapHan;
  String perpanjanganHan;

  ProsesTSK({this.id, this.spHan, this.tapHan, this.perpanjanganHan});

  factory ProsesTSK.fromJson(Map<String, dynamic> parsedJson) {
    return ProsesTSK(
      id: parsedJson["id"],
      spHan: parsedJson["sp_han"] as String,
      tapHan: parsedJson["tap_han"] as String,
      perpanjanganHan: parsedJson["surat_perpanjangan_han"] as String
    );
  }
}