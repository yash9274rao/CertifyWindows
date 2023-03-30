import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AddDevice extends StatelessWidget {
  const AddDevice({super.key});

  // This widget is the root of your application.
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textHolderModalController;
  var textHolderInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            margin: EdgeInsets.fromLTRB(180, 80, 180, 80),
            color: Colors.white,
            //          child: new Row(
            //              crossAxisAlignment : CrossAxisAlignment.start,
            //            children: [
            //              Image.asset("Assets/images/aerrow.png"),
            //            Text('Login to register the device',
            //            style:  TextStyle(fontWeight: FontWeight.bold,
            // fontSize: 30,
            // color: Colors.black87 ,//font color
            // decorationThickness: 2,
            //            ),
            //          ),
            //      )
            child: Column(
                // crossAxisAlignment : CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,top:10,right: 0,bottom: 10),
                  // height: 50,
                  // width: 50,

                //  child:  ImageIcon(
                //   AssetImage("images/assets/aerrow.png"),
                //   size:20,
                //
                // ),
                  child: IconButton(
                      icon: ImageIcon(
                        AssetImage('images/assets/aerrow.png'),
                        size: 60,
                        // color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      }),

                ),
                // Spacer(),

              // ElevatedButton.icon(
              //
              //       onPressed: (){
              //
              //       },
              //       icon: Icon(Icons.keyboard_backspace,color: Colors.black),
              //       label: Text(""),
              //
              //
              //   ),
                Padding(padding:EdgeInsets.all(10),

                child: Expanded(flex:4,child: Text(
                  'Add Device',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                    color: Colors.black87,
                    //font color
                    decorationThickness: 2,
                    //decoration 'underline' thickness
                    // fontStyle: FontStyle.italic
                  ),

                ),),
      )

              ],
            ),
                  // Image.asset("Assets/images/aerrow.png"),
                  Padding(padding:
                  const EdgeInsets.only(
                      left: 20,right:20,bottom: 5,top: 20
                  ),
                  child: TextField(

                    decoration: InputDecoration(
                            labelText:textHolderModalController,
                            enabled: false //disabel this text field input

                    ),

                  ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 20, right: 20, bottom: 20, top: 20),
                  //   child: Text('${textHolderModalController}'),
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.fromLTRB(20 ,20, 20, 0),
                  //
                  //   Padding(
                  //  padding: EdgeInsets.only(left: 25,right: 25,bottom: 0,top: 0),
                  // child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),

                    child: TextFormField(
                      // controller: _textEditingController,
                      // onChanged: (val) {
                      //   setState(() {
                      //     isEmailCorrect = isEmail(val);
                      //   });
                      // },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        enabledBorder: UnderlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5))),

                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Device Name",
                        // hintText: 'your-email@domain.com',
                        labelStyle: TextStyle(color: Colors.black26),
                        // suffixIcon: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.close,
                        //         color: Colors.purple))
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5.0)),
                  //         backgroundColor: Colors.indigo,
                  //         // padding: EdgeInsets.symmetric(
                  //         //     horizontal: MediaQuery.of(context).size.width / 20,
                  //         //     vertical: 10)
                  //         // padding: const EdgeInsets.all(30)
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 170, vertical: 20)
                  //
                  //         //      padding: const EdgeInsets.all(20)
                  //         ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => QRViewExample()));
                  //     },
                  //     child: Text(
                  //       'Save',
                  //       style: TextStyle(fontSize: 19),
                  //       // textAlign: TextAlign.justify,
                  //
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(child: ElevatedButton(
                          onPressed: () {},child: Text("Cancel",style:TextStyle(fontSize: 20),
                      ),
                        style: const ButtonStyle(
                      visualDensity: VisualDensity(
                      horizontal: VisualDensity.maximumDensity,
                        vertical: VisualDensity.maximumDensity,
                      ),
        ),
                      )
                      ),
                      //
                      SizedBox(
                        width: 70, //<-- SEE HERE
                      ),
                      Expanded(child: ElevatedButton(onPressed: () {},child: Text("Save", style:TextStyle(fontSize: 20),),
                        style: const ButtonStyle(

                        visualDensity: VisualDensity(
                        horizontal: VisualDensity.maximumDensity,
                        vertical: VisualDensity.maximumDensity,
                      ),),

                      ),)],
    ),
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 15),
                    child: Text(
                      '${textHolderInfo}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          wordSpacing: 1,
                          // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                          color: Colors.grey),
                    ),
                  ),
        ]),
      ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.serialNumber}'); // e.g. "Moto G (4)"
      setState(() {
        textHolderModalController = '${androidInfo.model} Tablet';
        textHolderInfo = 'Device Model:${androidInfo.model},Android version:${androidInfo.version},Serial Number:${androidInfo.serialNumber}';
      });
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        textHolderModalController = '${iosInfo.utsname.machine} Tablet';
        textHolderInfo = 'Device Model:${iosInfo.name},ios version:${iosInfo.systemVersion},Serial Number:${iosInfo.identifierForVendor}';

      });
      //   print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // textHolderModal = 'If you have already added the device on the '
      //     'portal SL NO:${webBrowserInfo.userAgent}';
      setState(() {
        textHolderModalController = ' ${webBrowserInfo.browserName.name}';
        textHolderInfo = 'Device Model:${webBrowserInfo.browserName.name},Browser:${webBrowserInfo.appVersion},Serial Number:${webBrowserInfo.appName}';

      });
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
      setState(() {
        textHolderModalController = '${macOsDeviceInfo.model}';
        textHolderInfo = 'Device Model:${macOsDeviceInfo.model},MacOs:${macOsDeviceInfo.osRelease},Serial Number:${macOsDeviceInfo.systemGUID}';

      });
    }
  }
}
