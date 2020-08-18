class StatusTSK {
  int id;
  String statusPenahanan;
  String keterangan;

  StatusTSK({this.id, this.statusPenahanan, this.keterangan});

  factory StatusTSK.fromJson(Map<String, dynamic> parsedJson) {
    return StatusTSK(
      id: parsedJson["id"],
      statusPenahanan: parsedJson["status_penahanan"] as String,
      keterangan: parsedJson["keterangan"] as String,
    );
  }
}