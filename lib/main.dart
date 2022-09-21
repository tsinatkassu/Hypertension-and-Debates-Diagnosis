import 'package:diabetic_measure/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetic Measure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Started"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "WELCOME",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40.0,
                color: Colors.blue,
              ),
            ),
            Image.asset(
              "assets/logo.png",
              height: 350,
            ),

            //// Get Started Button ////
            OutlinedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.subdirectory_arrow_right),
                  Text("Get Started"),
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
                      builder: (context) => Dashboard(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
