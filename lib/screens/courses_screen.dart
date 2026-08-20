import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../services/api_service.dart';

class CoursesScreen extends StatefulWidget {
  final Student student;
  final Function(Student)? onStudentUpdated;

  const CoursesScreen({
    super.key,
    required this.student,
    this.onStudentUpdated,
  });

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Student> _allStudents = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() async {
    try {
      final students = await ApiService.fetchStudents();
      setState(() {
        _allStudents = students;
        _filteredStudents = students;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredStudents = _allStudents
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _deleteStudent(String id) async {
    bool success = await ApiService.deleteStudent(id);
    if (success) {
      setState(() {
        _allStudents.removeWhere((s) => s.id == id);
        _filteredStudents.removeWhere((s) => s.id == id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student is success full pase!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              decoration: const InputDecoration(
                labelText: 'Search Students...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final item = _filteredStudents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    title: Text(item.name),
                    subtitle: Text(item.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(item.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(item.name),
                          content: Text('Email: ${item.email}\nDepartment: ${item.department}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
