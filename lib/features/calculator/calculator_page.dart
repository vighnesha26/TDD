import 'dart:async';

import 'package:flutter/material.dart';

class StringCalculatorPage extends StatelessWidget {
  final _controller = TextEditingController();

  String result = '';

  final sum = StreamController.broadcast();

  void calculateSum() {
    final value = add(_controller.text);
    sum.sink.add(value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(' Calculator')),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 600,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      decoration:
                          const InputDecoration(labelText: 'Enter numbers'),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: calculateSum, child: const Text('Add')),
                    const SizedBox(height: 10),
                    StreamBuilder(
                        initialData: 0,
                        stream: sum.stream,
                        builder: (context, snapshot) {
                          return Text('Sum : ${snapshot.data}');
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

int add(String numbers) {
  if (numbers.isEmpty) return 0;
  numbers = numbers.replaceAll(r'\n', '\n');
  String delimiterPattern = r'[, ,\n ; //]';
  String input = numbers;

  if (input.startsWith('//')) {
    final delimiterEnd = input.indexOf('\n');
    if (delimiterEnd == -1) {
      throw const FormatException('Invalid custom delimiter format.');
    }

    final customDelimiter = input.substring(1, delimiterEnd);
    delimiterPattern = RegExp.escape(customDelimiter);
    input = input.substring(delimiterEnd + 1);
  }

  final regex = RegExp(delimiterPattern);
  final parts = input.split(regex);

  final negatives = <int>[];
  int sum = 0;

  for (final part in parts) {
    final value = int.tryParse(part.trim());
    if (value == null) continue;
    if (value < 0) {
      negatives.add(value);
    } else {
      sum += value;
    }
  }
  if (negatives.isNotEmpty) {
    throw Exception('negative numbers not allowed: ${negatives.join(', ')}');
  }
  return sum;
}
