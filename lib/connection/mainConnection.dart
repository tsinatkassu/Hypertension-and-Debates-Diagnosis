//@dart=2.9
import 'package:diabetic_measure/connection/data_receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:diabetic_measure/connection/SelectBondedDevicePage.dart';

class MainConnection extends StatelessWidget {
  final String diagnosisType;
  MainConnection({@required this.diagnosisType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              child: Center(
                child: Icon(
                  Icons.bluetooth_disabled,
                  size: 200.0,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        } else if (future.connectionState == ConnectionState.done) {
          // return MyHomePage(title: 'Flutter Demo Home Page');
          return Home(diagnosisType: diagnosisType);
        } else {
          return Home(
            diagnosisType: diagnosisType,
          );
        }
      },
      // child: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatelessWidget {
  final String diagnosisType;

  Home({this.diagnosisType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Connection'.toString()),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DataReceive(
                  server: device,
                  diagnosisType: diagnosisType,
                );
              },
            ),
          );
        },
      ),
    ));
  }
}
