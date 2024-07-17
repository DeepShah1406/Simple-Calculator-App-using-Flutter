import 'package:flutter/material.dart';

//Creating Stateless Widget for buttons
class MyButton extends StatelessWidget
{
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  const MyButton({super.key, this.color, this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context)
  {
    TextStyle ts = TextStyle(color: textColor, fontSize: 25, fontWeight: FontWeight.bold);
    Text txt = Text(buttonText, style: ts);
    Center cnt = Center(child: txt);
    Container ct = Container(color: color, child: cnt);
    ClipRRect crr = ClipRRect(child: ct);
    Padding pd = Padding(padding: const EdgeInsets.all(0.2), child: crr);
    GestureDetector gd = GestureDetector(onTap: buttontapped, child: pd);
    return gd;
  }
}