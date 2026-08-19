import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../widgets/custom_card.dart';

class ProfileScreen extends StatelessWidget {
  final Student student;

  const ProfileScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              student.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              student.email,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 10),
            CustomCard(
              title: 'Student ID',
              value: student.id,
              icon: Icons.badge,
            ),
            CustomCard(
              title: 'Department',
              value: student.department,
              icon: Icons.school,
            ),
            CustomCard(
              title: 'Academic Level',
              value: student.level,
              icon: Icons.grade,
            ),
          ],
        ),
      ),
    );
  }
}