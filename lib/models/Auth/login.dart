class Login {
  String email;
  int idUser;
  String token;

  Login({this.email, this.idUser, this.token});

  Login.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    idUser = json['id_user'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id_user'] = this.idUser;
    data['token'] = this.token;
    return data;
  }
}
