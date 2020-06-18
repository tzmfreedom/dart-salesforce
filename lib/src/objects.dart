class QueryResponse {
  List<SObject> records;
  int totalSize;
  bool done;
  String nextRecordsUrl;

  QueryResponse.fromJson(Map<String, dynamic> data) {
    List<dynamic> records = data['records'];
    this.records = records.map((e) => SObject.fromJson(e));
    this.totalSize = data['totalSize'];
    this.done = data['done'];
    this.nextRecordsUrl = data['nextRecordsUrl'];
  }
}

class SObject {
  Map<String, dynamic> attributes;
  Map<String, dynamic> fields;

  SObject.fromJson(Map<String, dynamic> data) {
    attributes = data['attributes'];
    fields = data['fields'];
  }
}