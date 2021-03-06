import 'package:calculator/provider/calculator_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

const buttonsBackgroundColor = Color(0xFF090E1C);
const backgroundColor = Colors.white12;
const yellowColor = Color(0xff044404);
const whiteColor = Color.fromARGB(255, 25, 134, 25);

AppBar appbar(
  BuildContext context,
  String title,
  IconData icon,
  Function() tap,
) {
  return AppBar(
    iconTheme: IconThemeData(color: Color(0xff044404)),
    backgroundColor: Color(0xFF090E1C),
    title: Text(
      title,
      style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 5, 85, 5),
          fontWeight: FontWeight.w400),
    ),
    actions: [
      IconButton(
        onPressed: tap,
        icon: Icon(
          icon,
          color: Color(0xff044404),
        ),
      ),
    ],
  );
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isColored, isEqualSign, canBeFirst;
  const CalculatorButton(
    this.label, {
    this.isColored = false,
    this.isEqualSign = false,
    this.canBeFirst = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider =
        Provider.of<CalculatorProvider>(context, listen: false);
    final TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      color: buttonsBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          calculatorProvider.addToEquation(
            label,
            canBeFirst,
            context,
          );
        },
        child: Center(
          child: isEqualSign
              ? Container(
                  height: mediaQuery.width * 0.1,
                  width: mediaQuery.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: yellowColor,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: textStyle?.copyWith(color: backgroundColor),
                    ),
                  ),
                )
              : Text(
                  label,
                  style: textStyle?.copyWith(
                      color: isColored ? yellowColor : whiteColor),
                ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(milliseconds: 400),
      backgroundColor: Color(0xff044404),
    ),
  );
}

List<CalculatorButton> buttons = <CalculatorButton>[
  CalculatorButton('AC', canBeFirst: false),
  CalculatorButton('???', canBeFirst: false),
  CalculatorButton('.', canBeFirst: false),
  CalculatorButton(' ?? ', isColored: true, canBeFirst: false),
  CalculatorButton('7'),
  CalculatorButton('8'),
  CalculatorButton('9'),
  CalculatorButton(' ?? ', isColored: true, canBeFirst: false),
  CalculatorButton('4'),
  CalculatorButton('5'),
  CalculatorButton('6'),
  CalculatorButton(' - ', isColored: true, canBeFirst: false),
  CalculatorButton('1'),
  CalculatorButton('2'),
  CalculatorButton('3'),
  CalculatorButton(' + ', isColored: true, canBeFirst: false),
  CalculatorButton('00'),
  CalculatorButton('0'),
  CalculatorButton('000'),
  CalculatorButton('=', isEqualSign: true, canBeFirst: false),
];
