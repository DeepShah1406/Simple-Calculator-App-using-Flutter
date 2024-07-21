import 'package:simplecalculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9

  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width; // Get the screen width

    TextStyle ts = const TextStyle(fontSize: 48, fontWeight: FontWeight.bold);
    Text txt1 = Text("$number1$operand$number2".isEmpty? "0": "$number1$operand$number2", style: ts, textAlign: TextAlign.end);
    Container ct1 = Container(alignment: Alignment.bottomRight, padding: const EdgeInsets.all(16), child: txt1);
    SingleChildScrollView scsv = SingleChildScrollView(reverse: true, child: ct1);
    Expanded exp1 = Expanded(child: scsv);

    //SizedBox sb1 = SizedBox(width: value == Btn.n0? screenSize.width / 2: (screenSize.width / 4),height: screenSize.width / 5,child: buildButton(value));
    //Wrap wrp1 = Wrap(children: Btn.buttonValues.map((value) => SizedBox(width: value == Btn.n0? screenSize.width / 2: (screenSize.width / 4),height: screenSize.width / 5, child: buildButton(value))).toList());

    Wrap wrp1 = Wrap(children: Btn.buttonValues.map((value) => SizedBox(width: value == Btn.n0 ? screenWidth / 2 : screenWidth / 4, height: screenWidth / 5, child: buildButton(value),),).toList());

    Column cl1 = Column(children:[exp1, wrp1]);
    SafeArea sa = SafeArea(bottom: false, child: cl1);
    Scaffold sf = Scaffold(body: sa);
    MaterialApp ma = MaterialApp(debugShowCheckedModeBanner: false, home: sf);
    return ma;
  }

  Widget buildButton(value)
  {
    Text txt2 = Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));
    Center cnt = Center(child:  txt2);
    InkWell iw = InkWell(onTap: () => onBtnTap(value), child: cnt);
    Material m = Material(color: getBtnColor(value),clipBehavior: Clip.hardEdge,shape: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white24,),borderRadius: BorderRadius.circular(100),),child: iw);
    Padding pd = Padding(padding: const EdgeInsets.all(4.0), child: m);
    return pd;
  }

  void onBtnTap(String value)
  {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = "";
      number2 = "";
    });
  }

  void convertToPercentage() {
    // ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // calculate before conversion
      calculate();
    }

    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // clears all output
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // delete one from the end
  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  // #############
  // appends value to the end
  void appendValue(String value) {
    // number1 operand number2
    // 234       +      5343

    // if is operand and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    }
    // assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        // number1 = "" | "0"
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }

  // ########
  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
    ].contains(value)
        ? Colors.orange
        : Colors.black87;
  }
}