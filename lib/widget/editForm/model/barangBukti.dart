class BarangBukti {
  int id;
  String nama;

  BarangBukti({this.id, this.nama});

  factory BarangBukti.fromJson(Map<String, dynamic> parsedJson) {
    return  BarangBukti(
      id: parsedJson["id"],
      nama: parsedJson["nama_barang"] as String,
    );
  }
}