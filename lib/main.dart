import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Password Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final _lengthController = TextEditingController();
  String _generatedPassword = '';
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;
  double _passwordLength = 8;

  String _generatePassword(int length) {
    String chars = '';
    if (_includeUppercase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (_includeLowercase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (_includeNumbers) chars += '0123456789';
    if (_includeSymbols) chars += '!@#\$%^&*()_+[]{}|;:,.<>?';

    if (chars.isEmpty) return 'Select at least one character type';

    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ));
  }

  void _generate() {
    final length = _passwordLength.toInt();
    setState(() {
      _generatedPassword = _generatePassword(length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Password Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Length: ${_passwordLength.toInt()}'),
                Slider(
                  value: _passwordLength,
                  min: 4,
                  max: 20,
                  divisions: 16,
                  label: _passwordLength.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _passwordLength = value;
                    });
                  },
                ),
              ],
            ),
            CheckboxListTile(
              title: Text('Include Uppercase Letters'),
              value: _includeUppercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeUppercase = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Lowercase Letters'),
              value: _includeLowercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeLowercase = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Numbers'),
              value: _includeNumbers,
              onChanged: (bool? value) {
                setState(() {
                  _includeNumbers = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Symbols'),
              value: _includeSymbols,
              onChanged: (bool? value) {
                setState(() {
                  _includeSymbols = value ?? true;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _generate,
              child: Text('Generate Password'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Generated Password:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue),
              ),
              child: SelectableText(
                _generatedPassword,
                style: TextStyle(fontSize: 24, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
