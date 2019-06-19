class ServerResponse {
  final String message;
  final String error;

  ServerResponse({this.message, this.error});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(message: json["message"], error: json["error"]);
  }

  factory ServerResponse.withError(String errorValue) {
    return ServerResponse(message: null, error: errorValue);
  }
}
