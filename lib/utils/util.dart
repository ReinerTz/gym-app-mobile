class UtilApp {

  static String AppName = "Gym App";

  static T enumFromString<T>(String value, List<T> enumValues) {
    try {
      return enumValues.firstWhere((type) => type.toString().split('.').last == value);
    } catch (e) {
      throw Exception("Failed to convert enum");
    }
  }
}