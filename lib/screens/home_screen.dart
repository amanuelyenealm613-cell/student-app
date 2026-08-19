import 'package:flutter/material.dart';
import '../models/student_model.dart';
import 'profile_screen.dart';
import 'courses_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final Student student;
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.student,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Student currentStudent;

  @override
  void initState() {
    super.initState();
    currentStudent = widget.student;
  }

  void _updateStudentState(Student updatedStudent) {
    setState(() {
      currentStudent = updatedStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      // Dashboard View
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("እንኳን ደህና መጡ፣ ${currentStudent.name}!", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Department: ${currentStudent.department}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Total Enrolled Courses: ${currentStudent.enrolledCourses.length}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ProfileScreen(student: currentStudent),
      CoursesScreen(student: currentStudent, onStudentUpdated: _updateStudentState),
      const NotificationsScreen(),
      SettingsScreen(onThemeChanged: widget.onThemeChanged, isDarkMode: widget.isDarkMode),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Student Dashboard")),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}