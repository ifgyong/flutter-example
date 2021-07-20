class Util {
  static int _maxLen = 128;
  static String _tagValue = '';
  static void v(Object object, {String tag}) {
    log('$tag', ' e ', object);
  }

  static void log(String tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      print("$tag::$stag:: $da");
      return;
    }
    print(
        '$tag::$stag ============================= log start =============================');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print("${da.substring(0, _maxLen)}");
        da = da.substring(_maxLen, da.length);
      } else {
        print("$da");
        da = "";
      }
    }
    print(
        '$tag::$stag ============================= log end =============================');
  }
}
