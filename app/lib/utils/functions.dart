// import 'package:cloud_firestore/cloud_firestore.dart';

String toTitleCase(String string) {
  /// return a string in a title format
  String result = '';
  String c;
  for (var i = 0; i < string.length; i++) {
    if (i == 0) {
      c = capitaliseChar(string[i]);
    } else if (string.codeUnitAt(i - 1) == 32) {
      c = capitaliseChar(string[i]);
    } else {
      c = string[i];
    }
    result = result + c;
  }
  return result;
}

String capitaliseChar(String char) {
  // returns capitalised char
  String result = char;
  int code = char.codeUnitAt(0);
  if (code >= 97 && code <= 122) {
    result = String.fromCharCode(code - 32);
  }
  return result;
}

dynamic getField(Map<String, dynamic> map, String field,
    {dynamic onError, dynamic onNull}) {
  // onError: string to return when field does not exist
  try {
    return map[field] == null ? onNull : map[field];
  } catch (e) {
    return onError;
  }
}
