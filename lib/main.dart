import 'package:flutter/material.dart';
import 'package:flutter_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = "0", output = "0";

  onButtonClick(value) {
    if (value == "AC") {
      input = "0";
      output = "0";
    } else if (value == "<") {
      if (input.isNotEmpty) input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      input = output;
    } else if (value == ".") {
      if (!input.contains(".")) {
        input += value;
      }
    } else {
      input += value;
    }

    var userInput = input;
    userInput = input.replaceAll("x", "*");
    Parser p = Parser();
    Expression expression = p.parse(userInput);
    ContextModel cn = ContextModel();
    var finalValue = expression.evaluate(EvaluationType.REAL, cn);
    output = finalValue.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: 34, color: Colors.white.withOpacity(0.7)),
                )
              ],
            ),
          )),
          Row(
            children: [
              if (input.isNotEmpty)
                Button(
                    text: 'AC',
                    tColor: orangeColor,
                    buttonBgColor: operatorColor),
              if (input.isNotEmpty)
                Button(
                    text: '<',
                    tColor: orangeColor,
                    buttonBgColor: operatorColor),
              if (input.isNotEmpty)
                Button(text: '/', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              Button(text: '7'),
              Button(text: '8'),
              Button(text: '9'),
              if (input.isNotEmpty)
                Button(text: 'x', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              Button(text: '4'),
              Button(text: '5'),
              Button(text: '6'),
              if (input.isNotEmpty)
                Button(text: '-', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              Button(text: '1'),
              Button(text: '2'),
              Button(text: '3'),
              if (input.isNotEmpty)
                Button(text: '+', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              if (input.isNotEmpty)
                Button(text: '%', buttonBgColor: operatorColor),
              Button(text: '0'),
              if (input.isNotEmpty) Button(text: '.'),
              if (input.isNotEmpty)
                Button(text: '=', buttonBgColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget Button({
    Key? key,
    required String text,
    Color tColor = Colors.white,
    Color buttonBgColor = buttonColor,
  }) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: buttonBgColor,
                    foregroundColor: tColor,
                    padding: const EdgeInsets.all(22)),
                onPressed: () => onButtonClick(text),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ))));
  }
}
