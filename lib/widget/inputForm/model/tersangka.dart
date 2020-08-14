class Tersangka {
  int id;
  String nama;
  String umur;
  String jenisKelamin;
  String foto;

  Tersangka({this.id, this.nama, this.umur, this.jenisKelamin, this.foto});

  factory Tersangka.fromJson(Map<String, dynamic> parsedJson) {
    return  Tersangka(
      id: parsedJson["id"],
      nama: parsedJson["nama_tersangka"] as String,
      umur: parsedJson["umur"] as String,
      jenisKelamin: parsedJson["jenis_kelamin"] as String,
      foto: parsedJson["foto"] as String
    );
  }
}