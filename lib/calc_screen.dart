import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calcuolator extends StatefulWidget {
  const Calcuolator({Key? key}) : super(key: key);

  @override
  State<Calcuolator> createState() => _CalcuolatorState();
}

class _CalcuolatorState extends State<Calcuolator> {
  String userInput = '';
  String result = '0';

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: buttonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonList[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Color(0XFF1d2630),
      onTap: () {
        setState(() {
          handelButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: Offset(-3, -3),
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == ")" ||
        text == "(") {
      return Color.fromARGB(255, 252, 100, 100);
    } else {
      return Colors.white;
    }
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return Color.fromARGB(255, 104, 204, 159);
    } else {
      return Color(0XFF1d2630);
    }
  }

  handelButtons(String text) {
    if (text == 'AC') {
      userInput = '';
      result = '0';
      return;
    }
    if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {

        result = calculate();

      userInput = result;
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
        return;
      }
      if (userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');
        return;
      }
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evelotion = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evelotion.toString();
    } catch (e) {
      return 'Erorr While Calcaulating';
    }
  }
}
