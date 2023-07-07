import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/response/response_data_voluntear.dart';
import 'checkInCheckoutConfirmation.dart';

var _imageToShow = const Image(image: AssetImage('images/assets/final_logo.png'));

class VolunteerSchedulingList extends StatelessWidget {
  const VolunteerSchedulingList(
      {Key? key,
        required this.itemId,
        required this.name,
        required this.volunteerList})
      : super(key: key);
  final int itemId;
  final String name;
  final List<VolunteerSchedulingDetailList> volunteerList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me Kiosk',
      debugShowCheckedModeBanner: false,
      home: ConfirmLanch(itemId, name, volunteerList),
    );
  }
}
class ConfirmLanch extends StatefulWidget {
  ConfirmLanch(this.itemId,  this.name, this.volunteerList);

  final String name;
  final int itemId;
  final List<VolunteerSchedulingDetailList> volunteerList;
  @override
  CheckInSlots createState() => CheckInSlots();
}

class CheckInSlots extends State<ConfirmLanch> {
  var _imageToShow =
      const Image(image: AssetImage('images/assets/final_logo.png'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                          padding: const EdgeInsets.fromLTRB(120, 50, 10, 0),
                      child: Container(
                        child: _imageToShow,
                      ),),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(120, 10, 120, 50),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0))),
                                  child: ListView(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        80, 10, 10, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  7.0))),
                                                  child: IconButton(
                                                      icon: const ImageIcon(
                                                        AssetImage(
                                                            'images/assets/aerrow.png'),
                                                        size: 30,
                                                        // color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        print("efewfewfwefe");
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    false)
                                                            .pop(context);
                                                      }),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      3, 10, 10, 0),
                                              child: Text(
                                                'Select the assignment',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                                                  color: Colors.black87,
                                                  //font color
                                                  decorationThickness:
                                                      2, //decoration 'underline' thickness
                                                  // fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding:  const EdgeInsets.fromLTRB(
                                            70, 5, 70, 0),
                                            child: InkWell(
                                              onTap:(){
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CheckinCheckOutConfirmation(
                                                            )));
                                                },
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget.volunteerList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.all(15),
                                                padding: EdgeInsets.all(15),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  widget.volunteerList[index].scheduleTitle,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),

                                                ),

                                              );
                                            }),
                                        ) )]))))
                    ])))));
  }
}
