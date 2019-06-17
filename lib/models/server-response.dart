class ServerResponse {
  final int code;
  final String message;
  final String error;

  ServerResponse({this.code, this.message, this.error});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(code: json["code"], message: json["message"], error: json["error"]);
  }

  factory ServerResponse.withError(String errorValue) {
    return ServerResponse(code: 500, message: null, error: errorValue);
  }
}
