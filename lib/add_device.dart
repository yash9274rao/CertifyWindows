import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/response/register_device/register_device_response.dart';
import 'package:certify_me_kiosk/main.dart';
import 'package:certify_me_kiosk/toast.dart';

import 'api/api_service.dart';
import 'api/response/register_device/response_data.dart';
import 'common/sharepref.dart';

const List<String> listDeviceData = <String>['Select Device', '+ Add New'];
const List<String> listSettings = <String>['Default'];

class AddDevice extends StatelessWidget {
  const AddDevice(
      {Key? key,
      required this.offlineDeviceData,
      required this.tabletSettingData})
      : super(key: key);
  final List<OfflineDeviceData> offlineDeviceData;

  final List<TabletSettingData> tabletSettingData;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me Kiosk',
      home: MyHomePage(offlineDeviceData, tabletSettingData),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.offlineDeviceData, this.tabletSettingData);

  final List<OfflineDeviceData> offlineDeviceData;

  final List<TabletSettingData> tabletSettingData;

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
  final _formAddDeviceKey = GlobalKey<FormState>();
  String _deviceName = "";
  // String selectDevicename = "";
  String dropdownDeviceName = listDeviceData.first;
  String deviceSettings = listSettings.first;
  int deviceId = 0;
  int settingId = 0;

  var _isVisibility = false;
  var dropdownVisiability = false;
  var _isAddDevice = false;
  List<String>  dropdownDataDeviceName = [];
  List<String> dropdownDataDeviceSetting = [];
  late String selectDevicename =listSettings.first;
  late OfflineDeviceData offlineDeviceDataSelected;
  @override
  void initState() {
    super.initState();
    dropdownDataDeviceName.add("Select Device");
    for (var data in widget.offlineDeviceData){
      dropdownDataDeviceName.add(data.deviceName);
    }
    for (var data in widget.tabletSettingData){
      dropdownDataDeviceSetting.add(data.settingName);
    }

    dropdownDataDeviceName.add("+ Add New");
    dropdownDeviceName = dropdownDataDeviceName.first;
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formAddDeviceKey,
          child: Container(
            margin: const EdgeInsets.fromLTRB(180, 80, 180, 80),
            color: Colors.white,
            child: Column(
                // crossAxisAlignment : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 0, bottom: 10),
                        child: IconButton(
                            icon: const ImageIcon(
                              AssetImage('images/assets/aerrow.png'),
                              size: 60,
                              // color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            }),
                      ),
                      // Spacer(),

                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: AutoSizeText('Add Device',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                              color: Colors.black87,
                              //font color
                              decorationThickness: 2,
                              //decoration 'underline' thickness
                              // fontStyle: FontStyle.italic
                            ),
                            minFontSize: 22,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  // Image.asset("Assets/images/aerrow.png"),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 20),
                    child: Visibility(
                      visible: _isAddDevice,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerStart,
                        value: dropdownDeviceName,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownDeviceName = value!;
                            if (dropdownDeviceName == "+ Add New") {
                                _isVisibility = true;
                                dropdownVisiability = true;
                            } else{
                              _isVisibility = false;
                              dropdownVisiability = false;
                            }

                          });
                        },
                        items: dropdownDataDeviceName
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: Visibility(
                      visible: _isVisibility,
                      child: TextFormField(
                          onSaved: (val) => _deviceName = val!,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: UnderlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),

                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Enter Device Name",
                            // hintText: 'your-email@domain.com',
                            labelStyle: TextStyle(color: Colors.black26),
                          ),
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 20),
                      child: Visibility(
                          visible: dropdownVisiability,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerStart,
                        value: deviceSettings,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (newValue) {
                          // This is called when the user selects an item.
                          setState(() {
                            deviceSettings = newValue!;
                          });
                        },
                        items: dropdownDataDeviceSetting.map<DropdownMenuItem<String>>((String value)
                        {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                        );
                          }).toList(),
                      ) )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(context);
                          },
                          style: const ButtonStyle(
                            visualDensity: VisualDensity(
                              horizontal: VisualDensity.maximumDensity,
                              vertical: VisualDensity.maximumDensity,
                            ),
                          ),
                          child: const AutoSizeText("Cancel",
                              style: TextStyle(fontSize: 26),
                              minFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        )),
                        //
                        const SizedBox(
                          width: 70, //<-- SEE HERE
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _formAddDeviceKey.currentState!.save();
                              print("fffffffffffff dropdownValue =" +
                                  dropdownDeviceName);

                              if (_isAddDevice &&
                                  dropdownDeviceName == "Select Device") {
                                context.showToast("Please Select Device");
                              } else if (dropdownDeviceName == "+ Add New" &&
                                  _deviceName.isEmpty) {
                                context.showToast("Please enter Device Name");
                              } else {
                                addDevice();
                              }
                            },
                            style: const ButtonStyle(
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.maximumDensity,
                                vertical: VisualDensity.maximumDensity,
                              ),
                            ),
                            child: const AutoSizeText("Save",
                                style: TextStyle(fontSize: 26),
                                minFontSize: 18,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 15),
                    child: AutoSizeText('$textHolderInfo',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            wordSpacing: 1,
                            // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                            color: Colors.grey),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                   ]),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      // listDeviceData.clear();
      // for(var item in widget.offlineDeviceData){
      //   listDeviceData.add(item.deviceName);
      // }
      //
      // listSettings.clear();
      // for(var itemS in widget.tabletSettingData){
      //   listSettings.add(itemS.settingName);
      // }
      textHolderModalController = pref.getString(Sharepref.platform);
      if (pref.getString(Sharepref.platform) == "web") {
        _isAddDevice = true;
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}';
      } else {
        _isAddDevice = false;
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}, Serial Number: ${pref.getString(Sharepref.serialNo)}';
      }
    });
  }

  Future<void> addDevice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (_isAddDevice) {
      if (_deviceName.isEmpty) {
        _deviceName = dropdownDeviceName;
        pref.setString(Sharepref.serialNo, _deviceName);
        for (var data in widget.offlineDeviceData){
          if (dropdownDeviceName == data.deviceName){
            offlineDeviceDataSelected = data;
            break;
          }
        }
    if(offlineDeviceDataSelected != null){
      if(offlineDeviceDataSelected.deviceStatus == 0){
        deviceId = offlineDeviceDataSelected.deviceId;
        settingId = offlineDeviceDataSelected.settingId;
        addDeviceAPI();
      }else{
        // offline device just active
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),);

      }
    }
      }else{
        pref.setString(Sharepref.serialNo, _deviceName);
        addDeviceAPI();
      }
    } else {
      addDeviceAPI();
    }
  }
  Future<void> addDeviceAPI() async {
    for (var data in widget.tabletSettingData){
      if(deviceSettings == data.settingName){
        settingId = data.id;
      }
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> registerBody = HashMap();
    registerBody['deviceType'] = pref.getString(Sharepref.platformId);
    registerBody['deviceName'] = _deviceName;
    registerBody['serialNumber'] = pref.getString(Sharepref.serialNo);
    registerBody['IMEINumber'] = "";
    registerBody['status'] = 1;
    registerBody['settingsId'] = settingId;
    registerBody['deviceId'] = deviceId;

    RegisterDeviceResponse registerDeviceResponse = await ApiService()
        .registerDeviceForApp(pref, registerBody) as RegisterDeviceResponse;
    if (registerDeviceResponse.responseCode == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      context.showToast(registerDeviceResponse.responseMessage!);
    }
  }



}
