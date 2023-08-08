import 'package:flutter/material.dart';
import 'package:shared_pref/preferences_service.dart';
import 'models.dart';
import 'components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _usernameController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  // ignore: prefer_final_fields
  var _selectedLanguages = Set<ProgrammingLanguage>();
  var _isEmployed = false;
  final _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _usernameController.text = settings.username;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.programmingLanguages;
      _isEmployed = settings.isEmployed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User Settings'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
            ),
            RadioListTile(
              title: const Text('Female'),
              value: Gender.FEMALE,
              groupValue: _selectedGender,
              onChanged: (newValue) => setState(
                () {
                  _selectedGender = newValue!;
                },
              ),
            ),
            RadioListTile(
              title: const Text('Male'),
              value: Gender.MALE,
              groupValue: _selectedGender,
              onChanged: (newValue) => setState(
                () {
                  _selectedGender = newValue!;
                },
              ),
            ),
            RadioListTile(
              title: const Text('Other'),
              value: Gender.OTHER,
              groupValue: _selectedGender,
              onChanged: (newValue) => setState(
                () {
                  _selectedGender = newValue!;
                },
              ),
            ),
            CheckboxListTile(
              title: const Text('Dart'),
              value: _selectedLanguages.contains(ProgrammingLanguage.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguage.DART)
                      : _selectedLanguages.add(ProgrammingLanguage.DART);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Python'),
              value: _selectedLanguages.contains(ProgrammingLanguage.PYTHON),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.PYTHON)
                      ? _selectedLanguages.remove(ProgrammingLanguage.PYTHON)
                      : _selectedLanguages.add(ProgrammingLanguage.PYTHON);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Kotlin'),
              value: _selectedLanguages.contains(ProgrammingLanguage.KOTLIN),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.KOTLIN)
                      ? _selectedLanguages.remove(ProgrammingLanguage.KOTLIN)
                      : _selectedLanguages.add(ProgrammingLanguage.KOTLIN);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Swift'),
              value: _selectedLanguages.contains(ProgrammingLanguage.SWIFT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.SWIFT)
                      ? _selectedLanguages.remove(ProgrammingLanguage.SWIFT)
                      : _selectedLanguages.add(ProgrammingLanguage.SWIFT);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Is Employed'),
              value: _isEmployed,
              onChanged: (newValue) => setState(
                () {
                  _isEmployed = newValue;
                },
              ),
            ),
            TextButton(
              onPressed: _saveSettings,
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      username: _usernameController.text,
      gender: _selectedGender,
      programmingLanguages: _selectedLanguages,
      isEmployed: _isEmployed,
    );
    _preferencesService.saveSettings(newSettings);
  }
}
