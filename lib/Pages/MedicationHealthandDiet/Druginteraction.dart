// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugInteractionPage extends StatefulWidget {
  const DrugInteractionPage({super.key});

  @override
  _DrugInteractionPageState createState() => _DrugInteractionPageState();
}

class _DrugInteractionPageState extends State<DrugInteractionPage> {
  TextEditingController medication1Controller = TextEditingController();
  TextEditingController medication2Controller = TextEditingController();

  String result = '';

  Future<void> checkDrugInteraction(
      String medication1, String medication2) async {
    const apiKey = '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';
    const apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt':
            'Side effects of the interaction between $medication1 and $medication2',
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['choices'][0]['text'].replaceAll('\n', ' ');
      });
    } else {
      setState(() {
        result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drug Interaction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: medication1Controller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Enter Medication 1',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: medication2Controller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Enter Medication 2',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String medication1 = medication1Controller.text;
                String medication2 = medication2Controller.text;
                checkDrugInteraction(medication1, medication2);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Check Interaction',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Interaction Result: $result',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
