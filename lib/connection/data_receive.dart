//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:diabetic_measure/input_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DataReceive extends StatefulWidget {
  final BluetoothDevice server;
  final String diagnosisType;

  DataReceive({this.server, @required this.diagnosisType});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<DataReceive> {
  String msg = "";
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = List<_Message>();
  String _messageBuffer = '';
  List<String> values = [];

  double glucose = 0;
  //double bloodpressure = 0;
  double systolic = 0;
  double diasystolic = 0;

  String glu = "0";
  //String bp = "0";
  String sys = "0";
  String dia = "0";

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting Data to ' + widget.server.name + '...')
              : isConnected
                  ? Text('Live Data with '.toString() + widget.server.name)
                  : Text('Data log with '.toString() + widget.server.name))),
//      body: Column(
//        children: [
//          Text("Welcome"),
//          Text(humidity.toString()),
//          Text(N.toString()),
//        ],
//      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Measured Data
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Measured Data".toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

            //Glucose ||  BloodPressure Measurment
            (widget.diagnosisType == "Diabetics")
                ? CircularPercentIndicator(
                    radius: 130.0,
                    lineWidth: 8.0,
                    percent: glucose,
                    center: Text(
                      glu,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.grey[300],
                    progressColor: Colors.blue,
                    circularStrokeCap: CircularStrokeCap.round,
                    footer: Text(
                      "GLUCOSE LEVEL".toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 8.0,
                        percent: systolic,
                        center: Text(
                          sys,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.grey[300],
                        progressColor: Colors.blue,
                        circularStrokeCap: CircularStrokeCap.round,
                        footer: Text(
                          "Systolic Pressure".toString().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 8.0,
                        percent: diasystolic,
                        center: Text(
                          dia,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.grey[300],
                        progressColor: Colors.blue,
                        circularStrokeCap: CircularStrokeCap.round,
                        footer: Text(
                          "Diasystolic Pressure".toString().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 40.0,
            ),

            ElevatedButton(
              child: Text(
                "CONTINUE".toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                side: BorderSide(width: 1, color: Colors.blue.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                fixedSize: Size(300, 50),
              ),
              onPressed: () {
                if (glu != "0" && sys != "0" && dia != "0") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FetchData(
                                glucoseLevel: double.parse(glu),
                                systolicPressure: double.parse(sys),
                                diasystolicPressure: double.parse(dia),
                                diagnosisType: widget.diagnosisType,
                              )));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        if (backspacesCounter > 0) {
          msg = _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter);
        } else {
          msg = _messageBuffer + dataString.substring(0, index);
        }
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);

      if (_messageBuffer != '') {
        values = _messageBuffer.split(",");

        //assigning values to be converted to double percent
        _environmentalData(values[0], values[1], values[2]);

        // print("Message: " + msg);
        // print("N: " + values[0]);
        // print("P: " + values[1]);
        // print("K: " + values[2]);
        // print("Moisture: " + values[3]);
        // print("PH: " + values[4]);
        // print("humidity: " + values[5]);
        // print("Temprature: " + values[6]);
      }
    }
  }

  void _environmentalData(
      String glu_level, String sys_level, String diasys_level) {
    setState(() {
      if (glu_level.length > 4) {
        glu = glu_level.substring(0, 3);
      } else {
        glu = glu_level;
      }

      if (sys_level.length > 4) {
        sys = sys_level.substring(0, 3);
      } else {
        sys = sys_level;
      }

      if (diasys_level.length > 4) {
        dia = diasys_level.substring(0, 3);
      } else {
        dia = diasys_level;
      }

      // if (pot.length > 4) {
      //   k = pot.substring(0, 3);
      // } else {
      //   k = pot;
      // }

      // if (alka.length > 4) {
      //   PH = alka.substring(0, 3);
      // } else {
      //   PH = alka;
      // }

      // if (te.length > 5) {
      //   t = te.substring(0, 4);
      // } else {
      //   t = te;
      // }

      // if (moist.length > 5) {
      //   mos = moist.substring(0, 4);
      // } else {
      //   mos = moist;
      // }

      // if (humid.length > 5) {
      //   hum = humid.substring(0, 4);
      // } else {
      //   hum = humid;
      // }
    });

    //if the percent is greater than 1 (100 percent)
    //inaccurate value avoidance

    // if (N > 1) {
    //   N = 0;
    // }
    // if (P > 1) {
    //   P = 0;
    // }
    // if (K > 1) {
    //   K = 0;
    // }
    // if (ph > 1) {
    //   ph = 0;
    // }
    // if (temp > 1) {
    //   temp = 0;
    // }
    // if (moisture > 1) {
    //   moisture = 0;
    // }
    // if (humidity > 1) {
    //   humidity = 0;
    // }
  }
}
