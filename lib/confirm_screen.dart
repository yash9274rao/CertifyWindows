import 'package:flutter/material.dart';

import 'QRViewExmple.dart';

typedef StringValue = String Function(String);

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key, required this.dataStr}) : super(key: key);
  final String dataStr;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 5000), () {
      // Your code
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => QRViewExample()));
    });
    return new Scaffold(
      body: Center(
        child: Text(
          '${dataStr}',
        style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20),

      ),
      ),
    );
  }
}
