// ignore_for_file: prefer_const_constructors

import 'package:diabetic_measure/result_diabetic.dart';
import 'package:diabetic_measure/result_hypertension.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  final double glucoseLevel;
  final double systolicPressure;
  final double diasystolicPressure;
  final String diagnosisType;

  const FetchData(
      {@required this.systolicPressure,
      @required this.glucoseLevel,
      @required this.diasystolicPressure,
      @required this.diagnosisType});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  // Initial Selected Value
  String sex = "- Select Gender -";
  String age = "";
  String pregnancy = "- Select Pregnancy Status -";
  String typeOfTest = "- Select Type of Test-";
  String blurredVission = "- Blurred Vission Status -";
  String dryMouth = "- Dry Mouth Status -";
  String frequentUrination = "- Frequent Urination -";

  // Drop down items
  var itemSex = ['- Select Gender -', 'Male', 'Female'];
  var itemPregnancy = ['- Select Pregnancy Status -', 'Yes', 'No'];
  var itemTypeofTest = ['- Select Type of Test-', 'FGT', 'RGT'];
  var itemBlurredVission = ['- Blurred Vission Status -', 'Yes', 'No'];
  var itemDryMouth = ['- Dry Mouth Status -', 'Yes', 'No'];
  var itemFreqUrination = ['- Frequent Urination -', 'Yes', 'No'];

  bool isDiabeticTest = true;
  bool isValidated = true;

  // Input Validation
  bool validate() {
    if (age == "") {
      return false;
    } else if (sex == "- Select Gender -") {
      return false;
    } else if (pregnancy == '- Select Pregnancy Status -') {
      return false;
    } else if (blurredVission == '- Blurred Vission Status -') {
      return false;
    } else if (dryMouth == '- Dry Mouth Status -') {
      return false;
    } else if (frequentUrination == '- Frequent Urination -') {
      return false;
    } else if (typeOfTest == "- Select Type of Test-" && isDiabeticTest) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.diagnosisType == "Diabetics") {
      isDiabeticTest = true;
    } else {
      isDiabeticTest = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Input Additional Data",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30.0),
            ),

            SizedBox(
              height: 30,
            ),

            // Age Content
            new TextField(
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                age = value;
              },
              decoration: new InputDecoration(
                hintText: "Enter Your Age".toString(),
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Type of Test
            (isDiabeticTest)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Type of Test',
                        style: TextStyle(fontSize: 20),
                      ),
                      DropdownButton(
                        value: typeOfTest,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: itemTypeofTest.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String newTypeofTest) {
                          setState(() {
                            typeOfTest = newTypeofTest;
                          });
                        },
                      ),
                    ],
                  )
                : SizedBox(),

            SizedBox(
              height: (isDiabeticTest) ? 10 : 0,
            ),

            // Sex Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sex',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton(
                  value: sex,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: itemSex.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String newSexValue) {
                    setState(() {
                      sex = newSexValue;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            // Pregnancy Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Pregnancy Status',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton(
                  value: pregnancy,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: itemPregnancy.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String newPregnancy) {
                    setState(() {
                      pregnancy = newPregnancy;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Blurred Vission
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Blurred Vission',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton(
                  value: blurredVission,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: itemBlurredVission.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String newBlurredValue) {
                    setState(() {
                      blurredVission = newBlurredValue;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Dry Mouth
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Dry Mouth',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton(
                  value: dryMouth,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: itemDryMouth.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String newDryMouth) {
                    setState(() {
                      dryMouth = newDryMouth;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Frequent Urination
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Frequent Urination',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton(
                  value: frequentUrination,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: itemFreqUrination.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String newFrequentUrination) {
                    setState(() {
                      frequentUrination = newFrequentUrination;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Divider(
              height: 2,
            ),

            // Validation Warning
            (!isValidated)
                ? Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "All input fields are required!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 50,
            ),

            //Button
            ElevatedButton(
              child: Text(
                "Input Data",
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
                if (validate()) {
                  setState(() {
                    isValidated = true;
                  });
                  (isDiabeticTest)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultDiabetic(
                              age: age,
                              glucoseLevel: widget.glucoseLevel,
                              testType: widget.diagnosisType,
                            ),
                          ))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultHypertension(
                              diasystolicPressure: widget.diasystolicPressure,
                              systolicPressure: widget.systolicPressure,
                            ),
                          ));
                } else {
                  setState(() {
                    isValidated = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
