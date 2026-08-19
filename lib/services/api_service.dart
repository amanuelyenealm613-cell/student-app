import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  // GET: Fetch all students
  static Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Student.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  // POST: Add new student
  static Future<Student> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );
    if (response.statusCode == 201) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add student');
    }
  }

  // PUT: Edit/Update student
  static Future<bool> updateStudent(String id, Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );
    return response.statusCode == 200;
  }

  // DELETE: Delete student
  static Future<bool> deleteStudent(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }
}
