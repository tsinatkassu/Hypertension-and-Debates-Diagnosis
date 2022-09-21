import 'package:diabetic_measure/dashboard.dart';
import 'package:flutter/material.dart';

class ResultHypertension extends StatefulWidget {
  final double systolicPressure;
  final double diasystolicPressure;
  const ResultHypertension(
      {Key key, this.diasystolicPressure, this.systolicPressure})
      : super(key: key);

  @override
  State<ResultHypertension> createState() => _ResultHypertensionState();
}

class _ResultHypertensionState extends State<ResultHypertension> {
  //  \n \u2022
  String result = "";
  bool doneLoading = false;
  String lowBPM_msg =
      "If low blood pressure is causing symptoms, the treatment depends on the cause. For instance, if medication causes low blood pressure, your health care provider may recommend changing or stopping the medication or lowering the dose. Don't change or stop taking your medication without first talking to your care provider.  \n Depending on the reason for low blood pressure, the following steps might help reduce or prevent symptoms. \n     \u2022 Drink more water and less alcohol \n     \u2022 Pay attention to body position. Don't sit with legs crossed. \n     \u2022	Eat small, low –carb meals: include meat, fish, eggs, vegetables and natural fats, like butter. \n     \u2022	Exercise regularly ";
  String normalBPM_msg =
      " Even if your blood pressure is normal, it's important to engage in healthy lifestyle habits—the same ones you would engage in if your blood pressure was high. Again, some key habits include losing weight if you are overweight or obese, exercising every day, reducing alcohol consumption, and stopping smoking.";
  String highBPM_msg =
      "Foods to eat: \n      \u2022 Eat more fruits, vegetables, and low-fat dairy foods \n     \u2022	Cut back on foods that are High in saturated fat, cholesterol, and trans fats \n     \u2022	Eat more whole-grain foods, fish, poultry, and nuts \n Foods to avoid \n     \u2022	Frozen foods \n     \u2022 Salty and sugary foods \n      \u2022	Caffeine and alcohol \n      \u2022 Red meats ";

  String msg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var systolic = widget.systolicPressure;
    var diasystolic = widget.diasystolicPressure;

    if (systolic < 120) {
      if (diasystolic < 65) {
        result = "Low Blood Pressure";
        msg = lowBPM_msg;
      } else if (diasystolic >= 65 && diasystolic < 80) {
        result = "Normal";
        msg = normalBPM_msg;
      } else if (diasystolic >= 80 && diasystolic <= 90) {
        result = "Hypertension stage 1";
        msg = highBPM_msg;
      } else if (diasystolic > 90 && diasystolic <= 120) {
        result = "Hypertension Stage 2";
        msg = highBPM_msg;
      } else if (diasystolic > 120) {
        result = "Hypertensive Crisis \n Consult your doctor immediately";
      }
    } else if (systolic >= 120 && systolic < 130) {
      if (diasystolic < 80) {
        result = "Elevated";
        msg = normalBPM_msg;
      } else if (diasystolic >= 80 && diasystolic <= 90) {
        result = "Hypertension stage 1";
        msg = highBPM_msg;
      } else if (diasystolic > 90 && diasystolic <= 120) {
        result = "Hypertension Stage 2";
        msg = highBPM_msg;
      } else if (diasystolic > 120) {
        result = "Hypertensive Crisis \n Consult your doctor immediately";
      }
    } else if (systolic >= 130 && systolic < 140) {
      if (diasystolic < 90) {
        result = "Hypertension Stage 1";
        msg = highBPM_msg;
      } else if (diasystolic >= 90 && diasystolic < 120) {
        result = "Hypertension stage 2";
        msg = highBPM_msg;
      } else if (diasystolic >= 120) {
        result = "Hypertensive Crisis \n Consult your doctor immediately";
      }
    } else if (systolic >= 140 && systolic < 180) {
      if (diasystolic < 120) {
        result = "Hypertension Stage 2";
        msg = highBPM_msg;
      } else if (diasystolic >= 120) {
        result = "Hypertensive Crisis \n Consult your doctor immediately";
      }
    } else if (systolic >= 180) {
      result = "Hypertensive Crisis \n Consult your doctor immediately";
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
        title: Text("Hypertension Test Result"),
      ),
      body: Center(
        child: (doneLoading)
            ? SingleChildScrollView(
                child: Column(
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
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        msg,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
