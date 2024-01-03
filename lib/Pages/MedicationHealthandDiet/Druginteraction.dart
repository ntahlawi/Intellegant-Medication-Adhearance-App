import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medappfv/components/Themes/Sizing.dart';

class DrugInteractionPage extends StatefulWidget {
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
    const orgId = 'org-IHxAD2PIKvWvM4T5VJOGmPNK';
    const model = 'gpt-3.5-turbo';
    const apiUrl = 'https://api.openai.com/v1/engines/$model/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Openai-Org': orgId,
      },
      body: jsonEncode({
        'prompt':
            'side effects of the Interaction between $medication1 and $medication2',
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['choices'][0]['text'];
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Drug Interaction',
            style: TextStyle(
                color: Theme.of(context).textTheme.titleSmall!.color,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.screenWidth * 0.04)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.05,
                  color: Theme.of(context).textTheme.titleSmall!.color),
              controller: medication1Controller,
              decoration: const InputDecoration(
                labelText: 'Enter Medication 1',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.05,
                  color: Theme.of(context).textTheme.titleSmall!.color),
              controller: medication2Controller,
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
              child: Text('Check Interaction',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.screenWidth * 0.05)),
            ),
            const SizedBox(height: 16),
            Text(
              'Interaction Result: $result',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.screenWidth * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}
