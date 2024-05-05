import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = '0';
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
      _expression = '';
    } else if (buttonText == '=') {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        _output = eval.toString();
        _expression = '';
      } catch (e) {
        _output = 'Error';
      }
    } else {
      _expression += buttonText;
      _output = _expression;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CALCULATOR',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
            wordSpacing: 2.0,
            height: 12.5,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              height: MediaQuery.of(context).size.height *
                  0.4, // Adjust the height here
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // Add some spacing
            // Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  // Row 1
                  _buildButton('7', Colors.blue, 30.0),
                  _buildButton('8', Colors.blue, 30.0),
                  _buildButton('9', Colors.blue, 30.0),
                  _buildButton('/', Colors.blue, 30.0),
                  // Row 2
                  _buildButton('4', Colors.blue, 30.0),
                  _buildButton('5', Colors.blue, 30.0),
                  _buildButton('6', Colors.blue, 30.0),
                  _buildButton('*', Colors.blue, 30.0),
                  // Row 3
                  _buildButton('1', Colors.blue, 30.0),
                  _buildButton('2', Colors.blue, 30.0),
                  _buildButton('3', Colors.blue, 30.0),
                  _buildButton('-', Colors.blue, 30.0),
                  // Row 4
                  _buildButton('C', Colors.red, 30.0),
                  _buildButton('0', Colors.blue, 30.0),
                  _buildButton('=', Colors.green, 30.0),
                  _buildButton('+', Colors.blue, 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, Color color, double fontSize) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.05),
              side: BorderSide(color: Colors.black),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(5.0),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
