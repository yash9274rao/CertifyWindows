// import 'dart:html';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:snaphybrid/confirm_screen.dart';
//
// import 'numericKeyboard.dart';
//
// class PinViewPage extends StatefulWidget {
//   const PinViewPage({required this.attendanceMode});
//
//   final String attendanceMode;
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   // final String title;
//
//   @override
//   State<PinViewPage> createState() => PinViewPageState();
// }
//
//
//
// class PinViewPageState extends State<PinViewPage> {
//   final _formGlobalKey = GlobalKey<FormState>();
//   String pinValue = "";
//   bool _isVisible = false;
//   int maxLength = 5;
//   TextEditingController _myController = TextEditingController();
//   bool conditionValue = false;
//   bool isLoading = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _myController.addListener(() {
//         setState(() {
//           if (conditionValue = _myController.text == maxLength){
//           if (conditionValue){
//             startLoader();
//           }
//
//         }
//       }
//
//       );
//
//     });
//
//   }
//   void startLoader(){
//    setState(() {
//      isLoading = true;
//    });
//    // FocusManager.instance.primaryFocus?.unfocus();
// }
// void stopLoader(){
//     setState(() {
//       isLoading = false;
//     });
// }
//
//   @override
//   void dispose() {
//     _myController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget buildView(BuildContext context) {
//     return MaterialApp(
//
//       // title: "Demo Application",
//       home: Scaffold(
//         appBar: AppBar(title: new Text(""),),
//         body: SafeArea(
//           top: true,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//               SizedBox(
//               width: 250,
//               height: 200,
//                 child: TextFormField(
//                   controller: _myController,
//                   enabled: !isLoading,
//                   keyboardType: TextInputType.none,
//                   autofocus: true,
//                   // maxLength: 5,
//                   onSaved: (val) => <Object>
//                   {pinValue = val!,
//                   },
//                   obscuringCharacter: '*',
//                   obscureText: !_isVisible,
//                   decoration: InputDecoration(
//                     labelText: "Enter PIN",
//                     labelStyle: const TextStyle(color: Colors.black26),
//                     errorText: _errorText,
//                   ),
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//
//                 ),
//
//             ),
//
//                 SizedBox(height: 20),
//                 // const Spacer(),
//                 if(isLoading)
//
//                   const CircularProgressIndicator(),
//                 NumPad(
//                   // buttonSize: 75,
//                   // buttonColor: Colors.blue,
//                   iconColor: Colors.black54,
//                   controller: _myController,
//                   delete: () {
//                     _myController.text = _myController.text
//                         .substring(0, _myController.text.length - 1);
//                     stopLoader()  ;
//                   },
//                   //   // do something with the input numbers
//                   onSubmit: () {
//                     debugPrint('Your code: ${_myController.text}');
//                   },
//                 ),
//
//
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//      String? get _errorText { // at any time, we can get the text from _controller.value.text
//     final text = _myController.value.text;
//     if (text.length == maxLength) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => ConfirmScreen(dataStr: '${text}', attendanceMode:widget.attendanceMode,type:"pin"))
//       );
//       print(widget.attendanceMode);
//       // startLoader();
//
//       return '';
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//     // return null if the text is valid
//     return null;
//   }
//
//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       children: <Widget>[
//         Expanded(child: buildView(context)),
//
//       ],
//     ),
//   );
// }
//
//
//
//
//



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:certify_me_kiosk/confirm_screen.dart';

import 'numericKeyboard.dart';

class PinViewPage extends StatefulWidget {
const PinViewPage({Key? key,required this.attendanceMode}) : super(key: key);
final String attendanceMode;

@override
State<StatefulWidget> createState() => PinViewPageState();
}

class PinViewPageState extends State<PinViewPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  String pinValue = "";
  bool _isVisible = false;
  int maxLength = 5;
  TextEditingController _myController = TextEditingController();
  bool conditionValue = false;
  bool isLoading = false;


  // @override
  void initState() {
    super.initState();
    _myController.addListener(() {_errorText;});
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text(""),),
      body: SafeArea(
        top: true,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  height: 200,
                  child: TextFormField(
                    controller: _myController,
                    // enabled: !isLoading,
                    keyboardType: TextInputType.none,
                    autofocus: true,
                    onSaved: (val) =>
                    <Object>
                    {pinValue = val!,
                    },
                    obscuringCharacter: '*',
                    obscureText: !_isVisible,
                    decoration: InputDecoration(
                      labelText: "Enter PIN",
                      labelStyle: const TextStyle(color: Colors.black26),
                      errorText: _errorText,
                    ),
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),


                  ),

                ),

                // SizedBox(height: 20),
                // // const Spacer(),
                // if(isLoading)
                //
                //   const CircularProgressIndicator(),


                NumPad(
                  // buttonSize: 75,
                  // buttonColor: Colors.blue,
                  iconColor: Colors.black54,
                  controller: _myController,

                  delete: () {
                    _myController.text = _myController.text
                        .substring(0, _myController.text.length - 1);
                  },
                  //   // do something with the input numbers
                  onSubmit: () {
                    debugPrint('Your code: ${_myController.text}');
                  },
                ),

              ]),
        ),
      ),


    );
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _myController.value.text;
    if (text.length == maxLength) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>
          ConfirmScreen(dataStr: '${text}',
              attendanceMode: widget.attendanceMode,
              type: "pin"))
      );
      return '';
    }
  }
}