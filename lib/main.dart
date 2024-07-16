import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    MaterialApp m = const MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
    return m;
  }
}

class MainPage extends StatefulWidget
{
  const MainPage({super.key});
  @override
  UI createState() => UI();
}

class UI extends State<MainPage>
{
  var userInput = '';
  var answer = '';

  //Button's Array
  final List<String> buttons = [
    'DEL',
    '+/-',
    '%',
    'C',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  
  @override
  Widget build(BuildContext context)
  {
    //Text msg1 = const Text("Calculator App",style:TextStyle(fontSize:25,fontWeight:FontWeight.w500, color: Colors.black87 ));

    Container ct1 = Container(padding: const EdgeInsets.all(20), alignment: Alignment.centerRight, child: Text(userInput, style: const TextStyle(fontSize: 18, color: Colors.white)));
    Container ct2 = Container(padding: const EdgeInsets.all(15), alignment: Alignment.centerRight, child: Text(answer, style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)));
    Column cl1 = Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [ct1, ct2]);
    Container ct3 = Container(child: cl1);

    Expanded exp1 = Expanded(child: ct3);

    GridView gvb1 = GridView.builder(itemCount: buttons.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemBuilder: (BuildContext context, int index) {
      // Clear Button
      if (index == 0) {
        return MyButton(
          buttontapped: () {
            setState(() {
              userInput = '';
              answer = '0';
            });
            },
          buttonText: buttons[index],
          color: Colors.blue[50],
          textColor: Colors.black,
        );
      }

      // +/- button
      else if (index == 1) {
        return MyButton(
          buttonText: buttons[index],
          color: Colors.blue[50],
          textColor: Colors.black,
        );
      }

      // % Button
      else if (index == 2) {
        return MyButton(
          buttontapped: () {
            setState(() {
              userInput += buttons[index];
            });
            },
          buttonText: buttons[index],
          color: Colors.blue[50],
          textColor: Colors.black,
        );
      }

      // Delete Button
      else if (index == 3) {
        return MyButton(
          buttontapped: () {
            setState(() {
              userInput =
                  userInput.substring(0, userInput.length - 1);
            });
            },
          buttonText: buttons[index],
          color: Colors.blue[50],
          textColor: Colors.black,
        );
      }

      // Equal_to Button
      else if (index == 18) {
        return MyButton(
          buttontapped: () {
            setState(() {
              equalPressed();
            });
            },
          buttonText: buttons[index],
          color: Colors.orange[700],
          textColor: Colors.white,
        );
      }

      //  other buttons
      else {
        return MyButton(
          buttontapped: () {
            setState(() {
              userInput += buttons[index];
            });
            },
          buttonText: buttons[index],
          color: isOperator(buttons[index])
              ? Colors.blueAccent
              : Colors.white,
          textColor: isOperator(buttons[index])
              ? Colors.white
              : Colors.black,
        );
      }
    });

    Container ct4 = Container(child: gvb1);
    Expanded exp2 = Expanded(child: ct4);

    Column cl = Column(children: [exp1, exp2]);

    AppBar ab = AppBar(title: const Text('Calculator'), backgroundColor: Colors.white38);
    Scaffold sf = Scaffold(appBar: ab, body: cl,);
    MaterialApp m = MaterialApp(home: sf, debugShowCheckedModeBanner: false);
    return m;
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}