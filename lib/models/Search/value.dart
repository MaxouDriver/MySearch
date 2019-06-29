class Value {
  final String label;
  final String value;


  Value({this.label, this.value});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
        label: json['label'],
        value: json['value']
    );
  }
  @override
  toJson() {
    Map<String, dynamic> res = {
      "label": label,
      "value": value
    };
    return res;
  }

  @override
  toString(){
    return value;
  }
}