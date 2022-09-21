import 'package:diabetic_measure/connection/mainConnection.dart';
import 'package:diabetic_measure/input_data.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Diagnosis Type"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select what to Diagnosis",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              SizedBox(height: 15),

              //// Hypertension Test Button ////
              OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.subdirectory_arrow_right),
                    Text("Hypertension Test"),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  fixedSize: Size(300, 50),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainConnection(
                          diagnosisType: "Hypertension",
                        ),
                      ));
                },
              ),
              SizedBox(height: 15),
              //// Diabetics Test ////
              OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.subdirectory_arrow_right),
                    Text("Diabetics Test"),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  fixedSize: Size(300, 50),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainConnection(
                          diagnosisType: "Diabetics",
                        ),
                      ));
                },
              ),
            ],
          ),
        ));
  }
}
