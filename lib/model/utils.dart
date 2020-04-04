//
class _Util {
  const _Util();
  //
  bool url(String input) => RegExp(r"^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$").hasMatch(input);
  //
  String perOneMillionToString(dynamic input) {
    if (input is int) {
      return input.toString();
    } else if (input is double) {
      return input.toString();
    } else {
      return input ?? "0";
    }
  }
  //
  int dynamicToInt(dynamic input) {
    if (input is int) {
      return input;
    } else if (input is double) {
      return input.toInt();
    } else if (input is String) {
      return int.parse(input);
    } else {
      return 0;
    }
  }
  //
}
//
final _Util util = const _Util();
//
//


