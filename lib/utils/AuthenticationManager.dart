class AuthenticationManager{
  static String token;

  static void setToken(t){
    token = t;
  }

  static String getToken(){
    return token;
  }
}