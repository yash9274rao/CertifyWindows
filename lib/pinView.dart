// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';
import 'numericKeyboard.dart';

class PinView extends StatelessWidget {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
      ),
      home: const PinViewPage(title: ''),
    );
  }
}

class PinViewPage extends StatefulWidget {
  const PinViewPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PinViewPage> createState() => PinViewPageState();
}

class PinViewPageState extends State<PinViewPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  String pinValue = "";
  bool _isVisible = false;
  int maxLength = 5;
  TextEditingController _myController = TextEditingController();
  bool conditionValue = false;
  bool isLoading = false;

  @override
  void initState() {
    _myController.addListener(() {
      setState(() {
        if (conditionValue = _myController.text == maxLength){
          if (conditionValue){
            startLoader();
          }

        }
      }

      );

    });
    super.initState();
  }
  void startLoader(){
   setState(() {
     isLoading = true;
   });
   // FocusManager.instance.primaryFocus?.unfocus();
}
void stopLoader(){
    setState(() {
      isLoading = false;
    });
}

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Demo Application",
      home: Scaffold(
        appBar: AppBar(title: new Text(""),),
        body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
              width: 250,
              height: 200,

              // child: TextFormField(
              //   // decoration: InputDecoration(labelText: 'Enter Number'),
              //     cursorColor: Colors.grey,
              //   inputFormatters: [LengthLimitingTextInputFormatter(5)],
              //     // keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
              //     // inputFormatters: [
              //     //   FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              //     // ],
              //
              //   // 2nd method
              //   // keyboardType: TextInputType.number,
              //   // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //
              //   // 3rd method
              //
              //   // keyboardType: TextInputType.phone,
              //
              //   //4th method
              //
              //   // keyboardType: defaultTargetPlatform == TargetPlatform.iOS
              //   //     ? TextInputType.numberWithOptions(decimal: true, signed: true)
              //   //     : TextInputType.number,
              //   // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //
              //
              //
              //     controller: _myController,
              //             //       keyboardType: TextInputType.none,
              //             //         // readOnly: true,
              //             //         onTap: (){
              //             //
              //             //         },
              //
              //     autofocus: true,
              //     onSaved: (val) => pinValue = val!,
              //
              // obscuringCharacter: '*',
              // obscureText: !_isVisible,
              // decoration: InputDecoration(
              //   border: InputBorder.none,
                // focusedBorder: const UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey),
                //     borderRadius:
                //     BorderRadius.all(Radius.circular(5))),

                // enabledBorder: const UnderlineInputBorder(
                //   // borderSide: BorderSide.none,
                //     borderRadius:
                //     BorderRadius.all(Radius.circular(5))),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.grey),
                //   //  when the TextFormField in unfocused
                // ),
                // // filled: true,
                // fillColor: Colors.white,
                // labelText: "Enter PIN",
                // // hintText: 'your-email@domain.com',
                // labelStyle: const TextStyle(color: Colors.black26),

                // suffixIcon: IconButton(
                //   onPressed: () {
                //     setState(() {
                //       _isVisible = !_isVisible;
                //     });
                //   },
                //   icon: _isVisible ? const Icon(Icons.visibility, color: Colors.black,):
                //   const Icon(Icons.visibility_off, color: Colors.grey,),
                // )
              // ),
          //     style: TextStyle(fontSize: 40,
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //
          //
          //   ),
          // ),

          // const Spacer(),
          //
          // NumericKeypad(
          //   controller: _myController,
          // ),
          //
          // NumPad(
          //   // buttonSize: 75,
          //   // buttonColor: Colors.blue,
          //   iconColor: Colors.black54,
          //   controller: _myController,
          //   delete: () {
          //     _myController.text = _myController.text
          //         .substring(0, _myController.text.length - 1);
          //   },
          //   //   // do something with the input numbers
          //   onSubmit: () {
          //     debugPrint('Your code: ${_myController.text}');
          //     },
          // ),

           // ],
                child: TextFormField(
                  controller: _myController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.none,
                  autofocus: true,
                  // maxLength: 5,
                  onSaved: (val) => <Object>
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

                SizedBox(height: 20),
                // const Spacer(),
                if(isLoading)

                  const CircularProgressIndicator(),
                NumPad(
                  // buttonSize: 75,
                  // buttonColor: Colors.blue,
                  iconColor: Colors.black54,
                  controller: _myController,
                  delete: () {
                    _myController.text = _myController.text
                        .substring(0, _myController.text.length - 1);
                    stopLoader();
                  },
                  //   // do something with the input numbers
                  onSubmit: () {
                    debugPrint('Your code: ${_myController.text}');


                  },
                ),


            ]),
          ),
        ),
      ),
    );
  }
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _myController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.length == maxLength) {
      startLoader();

      return '';
    }
    // return null if the text is valid
    return null;
  }

}