class AdOwner {
  final String store_id;
  final String user_id;
  final String type;
  final String name;
  final bool no_salesmen;

  AdOwner({this.store_id, this.user_id, this.type, this.name, this.no_salesmen});

  factory AdOwner.fromJson(Map<String, dynamic> json) {
    return AdOwner(
        store_id: json['store_id'],
        user_id: json['user_id'],
        type: json['type'],
        name: json['name'],
        no_salesmen: json['no_salesmen']
    );
  }
}