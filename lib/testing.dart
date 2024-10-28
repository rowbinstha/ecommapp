class Log {
  static void v(String msg) {}

  static void catchE(e) {}

  static void e(String e) {}

  static void w(String w) {}
  static void faildResponse(value, String type) {
    w("Faild response $type");
    w(value.statusCode.toString());
    w(value.data.toString());
  }
}
