// ignore_for_file: prefer_const_constructors

import 'package:diabetic_measure/dashboard.dart';
import 'package:flutter/material.dart';

class ResultDiabetic extends StatefulWidget {
  final String age;
  final double glucoseLevel;
  final String testType;
  const ResultDiabetic({Key key, this.age, this.glucoseLevel, this.testType})
      : super(key: key);

  @override
  State<ResultDiabetic> createState() => _ResultDiabeticState();
}

class _ResultDiabeticState extends State<ResultDiabetic> {
  String result = '';
  String resultType = '';
  bool doneLoading = false;

  String lowGlucose_msg =
      "If your blood sugar has dropped, you need quick, rapid-acting liquid carbohydrates. There should be no fiber, fat, or protein present.";
  String normalGlucose_msg =
      " To Keep Blood Sugar Levels Steady \n  Eat fat and protein with each meal this is the absolute most important tip and recommendation, the key to balanced blood sugar levels. Because protein and fat are digested more slowly and so they slow the absorption of glucose into the bloodstream \n Protein and fat content foods are: \n     \u2022 Meat \n     \u2022	Egg \n     \u2022	Fish \n     \u2022	Cereal grains are moderately ";
  String highGlucose_msg =
      " The main goal of a good diet plan for a diabetic patient is thus to maintain the best levels of carbs, proteins, fats, and other nutrients. Carbohydrates control is essential for managing blood sugar levels. Healthy eating and regular exercise can help you regulate your blood sugar levels and finally reverse diabetes.\n Green leafy vegetables like kale, spinach, protein rich food like eggs, fatty fish, Greek Yoghurt, high fiber food like chia seeds, including Cinnamon, Nuts, etc. are good carbs that help in controlling diabetes ";
  String msg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var glucoseLevel = widget.glucoseLevel;
    var age = int.parse(widget.age);
    var testType = widget.testType;

    if (testType == "FGT") {
      if (glucoseLevel < 80) {
        result = 'Low Blood Glucose Level';
        resultType = '';
        msg = lowGlucose_msg;
      } else if (glucoseLevel >= 80 && glucoseLevel < 100) {
        result = 'Normal';
        resultType = '';
        msg = normalGlucose_msg;
      } else if (glucoseLevel >= 100 && glucoseLevel <= 125) {
        result = 'Pre-Diabetic';
        msg = highGlucose_msg;
        if (age < 30) {
          resultType = 'Type 1';
        } else {
          resultType = 'Type 2';
        }
      } else if (glucoseLevel > 125) {
        result = 'Diabetic';
        msg = highGlucose_msg;
        if (age < 30) {
          resultType = 'Type 1';
        } else {
          resultType = 'Type 2';
        }
      }
    } else {
      if (glucoseLevel < 110) {
        result = 'Low Blood Glucose Level';
        resultType = '';
        msg = lowGlucose_msg;
      } else if (glucoseLevel >= 110 && glucoseLevel < 140) {
        result = 'Normal';
        resultType = '';
        msg = normalGlucose_msg;
      } else if (glucoseLevel >= 140 && glucoseLevel <= 199) {
        result = 'Pre-Diabetic';
        msg = highGlucose_msg;
        if (age < 30) {
          resultType = 'Type 1';
        } else {
          resultType = 'Type 2';
        }
      } else if (glucoseLevel > 199) {
        result = 'Diabetic';
        msg = highGlucose_msg;
        if (age < 30) {
          resultType = 'Type 1';
        } else {
          resultType = 'Type 2';
        }
      }
    }

    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        doneLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetic Test Result"),
      ),
      body: Center(
        child: (doneLoading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RESULT",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    result.toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      msg,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    resultType.toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(
                    height: 50,
                  ),
                  //Button
                  ElevatedButton(
                    child: Text(
                      "Test Again",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      fixedSize: Size(300, 50),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ), (route) => false);
                    },
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
