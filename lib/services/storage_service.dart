import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_model.dart';

class StorageService {
  static const String _keyStudents = 'local_students';

  // Local Persistence: Save Offline Data
  static Future<void> saveStudentsLocally(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = students.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_keyStudents, jsonList);
  }

  // Load Persistence Across Application Restarts
  static Future<List<Student>> loadLocalStudents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_keyStudents);
    if (jsonList == null) return [];
    return jsonList.map((item) => Student.fromJson(jsonDecode(item))).toList();
  }
}