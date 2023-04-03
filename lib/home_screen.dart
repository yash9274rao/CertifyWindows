import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:snaphybrid/QRViewExmple.dart';
import 'package:intl/intl.dart';

import 'QRViewExmple.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  var timeTextHolderModalController = "", dateTextHolderModalController = "";
  late Timer dataTime;
  Map<String, dynamic> diveInfo = new HashMap();

  @override
  void initState() {
    super.initState();
    timeDateSet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: Container(
          color: Colors.white,
          child: Container(
            child: Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                            child: new Image(
                              image: AssetImage('images/assets/final_logo.png'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 20, 10, 15),
                            child: Text(
                              'Home Screen Text1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                            child: Text(
                              'Home Screen Text2',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                            child: Container(
                              color: Colors.blueGrey.shade900,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(80, 50, 80,
                                        5),
                                    child: Text(
                                      '${timeTextHolderModalController}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(80, 0, 80,
                                        50),
                                    child: Text(
                                      '${dateTextHolderModalController}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                        child: TextButton(
                            style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRViewExample()));
                          },
                          child: Text(" Check-In "),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.red.shade200,
                          ),
                          onPressed: () {
                            print("BBBBBBBBBBBBBBBBBBBB");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRViewExample()));
                          },
                          child: Text("Check-Out"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> timeDateSet() async {
    dataTime =  Timer.periodic(const Duration(seconds: 1), (dataTime) {
      String time = DateFormat('HH:mm a').format(DateTime.now());
      String date = DateFormat('EEEEE, dd MMM yyyy').format(DateTime.now());

      setState(() {
        timeTextHolderModalController = time;
        dateTextHolderModalController = date;
      });
    });

  }
  @override
  void dispose() {
    super.dispose();
    dataTime?.cancel();
  }
}
