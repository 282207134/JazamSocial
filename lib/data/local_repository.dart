import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// One small local snapshot. A remote repository can replace this boundary.
class LocalRepository {
  LocalRepository(this.preferences);
  final SharedPreferences preferences;
  static const key = 'jazam.state.v1';

  Map<String, dynamic> load() {
    try {
      return jsonDecode(preferences.getString(key) ?? '{}') as Map<String, dynamic>;
    } on FormatException {
      return {};
    } on TypeError {
      return {};
    }
  }

  Future<void> save(Map<String, dynamic> data) async {
    await preferences.setString(key, jsonEncode(data));
  }
}
