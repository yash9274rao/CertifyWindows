import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckinCheckOutConfirmation extends StatefulWidget {
  @override
  ConfirmationVolunteer createState() => ConfirmationVolunteer();
}

class ConfirmationVolunteer extends State<CheckinCheckOutConfirmation> {
  var _imageToShow =
      const Image(image: AssetImage('images/assets/final_logo.png'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
            body: Center(
                child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding:  const EdgeInsets.fromLTRB(150, 50, 10, 0),
                          child: Container(
                            child: _imageToShow,
                          ),),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(150, 50, 150, 150),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 100, 50, 50),
                                          child:Center(
                                          child: Text(
                                            "Checked In Successfully",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                          child:Center(
                                            heightFactor: 1.0,
                                            child: ElevatedButton(

                                              onPressed: () {

                                              }, child: Text("     OK     "),
                                              style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(fontSize: 20)
                                              ),

                                            ),
                                          )
                                        )]),
                                ),
                              ))
                        ])))));
  }
}
