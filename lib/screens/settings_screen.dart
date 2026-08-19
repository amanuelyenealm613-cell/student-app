import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Theme"),
            value: isDarkMode,
            onChanged: onThemeChanged,
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
    );
  }
}