import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.notifications_active, color: Colors.orange),
            title: Text("Registration Open"),
            subtitle: Text("Course registration for next semester is open."),
          ),
          ListTile(
            leading: Icon(Icons.event_available, color: Colors.green),
            title: Text("Exam Schedule"),
            subtitle: Text("Final exam schedules have been published."),
          ),
        ],
      ),
    );
  }
}