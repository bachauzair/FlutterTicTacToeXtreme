import 'package:flutter/material.dart';

import 'main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Difficulty _difficulty = Difficulty.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Select Difficulty Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildDifficultyOption('Easy', Difficulty.easy),
            buildDifficultyOption('Medium', Difficulty.medium),
            buildDifficultyOption('Hard', Difficulty.hard),
          ],
        ),
      ),
    );
  }

  Widget buildDifficultyOption(String label, Difficulty value) {
    return InkWell(
      onTap: () {
        setState(() {
          _difficulty = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: _difficulty == value ? Colors.blue : Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: _difficulty == value ? Colors.white : Colors.black,
              ),
            ),
            if (_difficulty == value) const Icon(Icons.check, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
