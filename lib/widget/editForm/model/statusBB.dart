class StatusBB {
  int id;
  String status;
  String keterangan;

  StatusBB({this.id, this.status, this.keterangan});

  factory StatusBB.fromJson(Map<String, dynamic> parsedJson) {
    return StatusBB(
      id: parsedJson["id"],
      status: parsedJson["status"] as String,
      keterangan: parsedJson["keterangan"] as String,
    );
  }
}