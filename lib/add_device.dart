import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/common/color_code.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/response/register_device/register_device_response.dart';
import 'package:certify_me_kiosk/main.dart';
import 'package:certify_me_kiosk/toast.dart';

import 'api/api_service.dart';
import 'api/response/register_device/response_data.dart';
import 'common/sharepref.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


const List<String> listDeviceData = <String>['Select Device', '+ Add New'];
const List<String> listSettings = <String>['Default'];
const List<String> listFacility = <String>['Select Facility'];

class AddDevice extends StatelessWidget {
  const AddDevice(
      {Key? key,
      required this.offlineDeviceData,
      required this.tabletSettingData,
      required this.facilityListData})
      : super(key: key);
  final List<OfflineDeviceData> offlineDeviceData;
  final List<TabletSettingData> tabletSettingData;
  final List<FacilityListData> facilityListData;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me KIOSK',
      home: MyHomePage(offlineDeviceData, tabletSettingData, facilityListData),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      this.offlineDeviceData, this.tabletSettingData, this.facilityListData);

  final List<OfflineDeviceData> offlineDeviceData;
  final List<TabletSettingData> tabletSettingData;
  final List<FacilityListData> facilityListData;

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
  String dropdownDeviceName = "";
  String deviceSettings = "";
  String deviceFacility = "";
  int deviceId = 0;
  int settingId = 0;
  int facilityId = 0;
  var _isVisibility = false,_isWebDevice = false;
  var dropdownVisiability = false;
  var dropdownFacilityVisiability = false;
  var _isAddDevice = false;
  bool _validateDeviceName = true;
  List<String> dropdownDataDeviceName = [];
  List<String> dropdownDataDeviceSetting = [];
  List<String> dropdownDataFacility = [];
  late String selectDevicename = listSettings.first;
  late OfflineDeviceData offlineDeviceDataSelected;
  late FacilityListData facilityListDataSelected;
  TextEditingController _textEditingControllerDeviceName = TextEditingController();
  TextEditingController _textEditingControllerSettings = TextEditingController();
  TextEditingController _textEditingControllerFacility = TextEditingController();
  late ProgressDialog _isProgressLoading;
  @override
  void initState() {
    super.initState();
    for (var data in widget.offlineDeviceData) {
      dropdownDataDeviceName.add(data.deviceName);
    }
    for (var data in widget.tabletSettingData) {
      dropdownDataDeviceSetting.add(data.settingName);
    }
    // dropdownDataFacility.add("Select Facility");
    for (var data in widget.facilityListData) {
      dropdownDataFacility.add(data.facilityName);
    }

    // dropdownDataDeviceName.add("+ Add New");
    if( widget.offlineDeviceData.isNotEmpty)
    dropdownDeviceName = dropdownDataDeviceName.first;
    if( widget.tabletSettingData.isNotEmpty)
      deviceSettings = dropdownDataDeviceSetting!.first;
    if( widget.facilityListData.isNotEmpty)
      deviceFacility = dropdownDataFacility.first;
    dropdownDataDeviceName = dropdownDataDeviceName.toSet().toList();
    dropdownDataDeviceSetting = dropdownDataDeviceSetting.toSet().toList();
    dropdownDataFacility = dropdownDataFacility.toSet().toList();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          color: Colors.white,
          height: _height,
          width: _width,
          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
          child: SingleChildScrollView(
              child: Form(
                  key: _formAddDeviceKey,
    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 55, 0, 40),
                          child: Image(
                            image: AssetImage('images/assets/final_logo.png'),
                          ),
                        ),
                        // crossAxisAlignment : CrossAxisAlignment.stretch,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffE0E9F2),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  splashColor: Colors.lime,
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(context);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: AutoSizeText('Add this device',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ColorCode.titleFont,
                                      color: Color(ColorCode.addColorTitle)),
                                  minFontSize: 22,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 45),
                            child: Divider(color: Colors.grey)),

                        Padding(padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 5, top: 0),
                            child: Visibility(
                              visible: _isWebDevice,
                          child: Row(children: [
                            Icon(Icons.add_to_queue,color:Color(ColorCode.addColorTitle),),
                            const SizedBox(
                              width: 20, //<-- SEE HERE
                            ),
                            Expanded(
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _textEditingControllerDeviceName,
                                  autofocus: false,
                                  style: TextStyle(fontSize: ColorCode.editTextFont),
                                  decoration: InputDecoration(
                                   // hintText: 'Device Name',
                                      labelText: 'Device Name',
                                    labelStyle: TextStyle(fontSize: ColorCode.editTextHintFont,color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: _validateDeviceName? Colors.grey :Colors.redAccent, width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: _validateDeviceName? Colors.blue :Colors.redAccent, width: 1.0),
                                    ),
                                      errorBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: _validateDeviceName? Colors.grey :Colors.redAccent, width: 1.0),
                                      ) ,
                                    suffixIcon: const ImageIcon(AssetImage('images/assets/aerrowdown.png'), size: 24,),
                                   ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  print('Selected: $pattern');
                                  return  dropdownDataDeviceName
                                      .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                                      .toList();
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: AutoSizeText(
                                      suggestion,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: ColorCode.subTextFont,
                                          color: Color.fromRGBO(21, 57, 92, 1)),
                                      minFontSize: 18,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                noItemsFoundBuilder:(context){
                                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp)  {
                                    print('noItemsFoundBuilder:${_textEditingControllerDeviceName.text}');

                                    setState(()  {
                                      if(_textEditingControllerDeviceName.text.startsWith('-')||_textEditingControllerDeviceName.text.startsWith('_')||!RegExp(r'^[a-zA-Z0-9_\-!]+$').hasMatch(_textEditingControllerDeviceName.text)) {
                                        _validateDeviceName = false;
                                      }else {
                                        _validateDeviceName = true;}
                                      dropdownVisiability = true;
                                      dropdownFacilityVisiability = true;
                                    });
                                  });
                                  return const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child:Text(
                                        'No match found. Continue to add this as a new.',
                                        style: TextStyle(fontSize: 17),
                                        // semanticsLabel: _textEditingControllerFacility.text = ""


                                      )
                                  );
                                },

                                onSuggestionSelected: (suggestion) {
                                  _textEditingControllerDeviceName.text = suggestion;
                                  _deviceName = _textEditingControllerDeviceName.text.trim();
                                  setState(() {
                                    dropdownVisiability = false;
                                    dropdownFacilityVisiability = false;
                                    _validateDeviceName = true;
                                  });
                                  print('onSuggestionSelected: $suggestion');
                                },
                              ),
                            ),
                          ]),
                        ),
                        ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 0),
                child: Visibility(
                      visible: _isVisibility,
                      child: Row(children: [
                        // Icon(Icons.add_to_queue,color:Color(ColorCode.addColorTitle),size: 32,),

                        const ImageIcon(AssetImage('images/assets/device.png'),),
                        const SizedBox(width: 20, ),
                        Expanded(
                          child: TextFormField(
                              onSaved: (val) => _deviceName = val!,
                              onChanged: (text){
                                setState(() {
                                  if (text.startsWith('-') || text.startsWith('_') ||
                                      !RegExp(r'^[a-zA-Z0-9_\-!]+$').hasMatch(text)) {
                                    _validateDeviceName = false;
                                  } else {
                                    _validateDeviceName = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                // focusedBorder: UnderlineInputBorder(
                                //     borderSide:
                                //     BorderSide(color: Colors.grey),
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(5))),
                                enabledBorder: UnderlineInputBorder(
                                  // borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: _validateDeviceName? Colors.blue :Colors.redAccent, width: 1.0),
                                ),
                                errorBorder:OutlineInputBorder(
                                  borderSide: BorderSide(color: _validateDeviceName? Colors.grey :Colors.redAccent, width: 1.0),
                                ) ,
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Enter Device Name",
                                // hintText: 'your-email@domain.com',
                                labelStyle: TextStyle(color: Colors.grey, fontSize: ColorCode.editTextHintFont),
                              ),
                              style: TextStyle(fontSize: ColorCode.editTextFont,)),

                        )]
                      ))
                      ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5, top: 20),
                            child: Visibility(
                                visible: dropdownVisiability,
                                child: Row(children: [
                                  // Icon(Icons.settings,color:Color(ColorCode.addColorTitle),size: 32,),

                                  const ImageIcon(AssetImage('images/assets/settings.png'),),
                                  const SizedBox(
                                    width: 20, //<-- SEE HERE
                                  ),
                                  Expanded(
                                  child: TypeAheadField(

                                    textFieldConfiguration: TextFieldConfiguration(
                                      controller: _textEditingControllerSettings,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        labelText: 'Device Settings',
                                        labelStyle: TextStyle(fontSize: ColorCode.editTextHintFont,color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                        suffixIcon: ImageIcon(AssetImage('images/assets/aerrowdown.png'),
                                          size: 24,
                                        ),
                                      ),
                                      style: TextStyle(fontSize: ColorCode.editTextFont,),

                                  ),

                                    suggestionsCallback: (pattern) async {

                                      print('Selected: $pattern');
                                      return  dropdownDataDeviceSetting
                                          .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                                          .toList();
                                    },

                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: AutoSizeText(
                                          suggestion,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: ColorCode.subTextFont,
                                              color: Color.fromRGBO(21, 57, 92, 1)),
                                          minFontSize: 18,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                    noItemsFoundBuilder:(context){
                                      return const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child:Text(
                                            'No records found',
                                            style: TextStyle(fontSize: 17),
                                            // semanticsLabel: _textEditingControllerFacility.text = ""

                                          )
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      _textEditingControllerSettings.text = suggestion;
                                      deviceSettings = _textEditingControllerSettings.text;
                                      print('Selected: $suggestion');
                                    },
                                  ),
                                  )]))),
                      // Facility
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 0, top: 20),
                            child: Visibility(
                                visible: dropdownFacilityVisiability,
                                child: Row(children: [
                                  const ImageIcon(AssetImage('images/assets/hospitalline.png'),),
                                  const SizedBox(
                                    width: 20, //<-- SEE HERE
                                  ),
                                  Expanded(
                                      child: TypeAheadField(
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: _textEditingControllerFacility,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            labelText: 'Facility Name',
                                            labelStyle: TextStyle(fontSize: ColorCode.editTextHintFont,color: Colors.grey),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 1.0),
                                            ),
                                            suffixIcon: ImageIcon(AssetImage('images/assets/aerrowdown.png'),
                                              size: 24,
                                            ),
                                          ),
                                            style: TextStyle(fontSize: ColorCode.editTextFont,),
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          print('Selected: $pattern');
                                          return  dropdownDataFacility
                                              .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                                              .toList();
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: AutoSizeText(
                                              suggestion,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: ColorCode.subTextFont,
                                                  color: Color.fromRGBO(21, 57, 92, 1)),
                                              minFontSize: 18,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        },
                                        noItemsFoundBuilder:(context){
                                          return Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child:Text('No records found',
                                              style: TextStyle(fontSize: ColorCode.subTextFont),
                                               // semanticsLabel: _textEditingControllerFacility.text = ""

                                            )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          _textEditingControllerFacility.text = suggestion;
                                          deviceFacility = _textEditingControllerFacility.text;
                                          print('Selected: $suggestion');

                                        },

                                      ),
                                  )]))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 65, right: 60, bottom: 20, top: 30),
                            child: Container(
                              // child: Padding(
                              //   padding: EdgeInsets.fromLTRB(55, 15, 45, 0),
                              child: TextButton(
                                onPressed: () {
                                  _formAddDeviceKey.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  addDevice();

                                },
                                style: TextButton.styleFrom(
                                  elevation: 20,
                                  shadowColor: Colors.grey,
                                  backgroundColor: Color(ColorCode.colorBg),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),),
                                ),

                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "Continue",
                                      style: TextStyle(
                                          fontSize: ColorCode.buttonFont, color: Colors.white),
                                      minFontSize: 18,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ),
                            )),
                            const SizedBox(
                              width: 30, //<-- SEE HERE
                            ), Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Icon(Icons.error_outline,color:Color(ColorCode.addColorTitle) , ) ,
                        ),
                        const SizedBox(
                          width: 20, //<-- SEE HERE
                        ),
                          Flexible(
                          child:  AutoSizeText('$textHolderInfo',
                              style: const TextStyle(
                                  fontSize: 18,
                                  // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                                  color: Colors.grey),
                              minFontSize: 18,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
          ]),
                            const SizedBox(width: 45,height: 16,),
                      ]))),

        ));
  }


  Future<void> initPlatformState() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      textHolderModalController = pref.getString(Sharepref.platform);
      if (pref.getString(Sharepref.platform) == "web") {
        _isAddDevice = true;
        _isWebDevice = true;
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}';
        //textHolderInfo = '';
      } else {
        _isAddDevice = false;
        _isVisibility = true;
        _isWebDevice = false;
        dropdownVisiability = true;
        dropdownFacilityVisiability = true;
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}, Serial Number: ${pref.getString(Sharepref.serialNo)}';
      }
    });
  }

  Future<void> addDevice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (_isAddDevice) {
      if (_textEditingControllerDeviceName.text.isEmpty) {
        context.showToast("Please enter device name");
      } else if(!_validateDeviceName){
        setState(() {
          _validateDeviceName = false;
        });
        context.showToast("Special characters are not allowed");}else {
        _deviceName = _textEditingControllerDeviceName.text.trim();
        pref.setString(Sharepref.serialNo, _deviceName);
        bool isDeviceName = false;
        for (var data in widget.offlineDeviceData) {
          if (_deviceName == data.deviceName.trim()) {
            offlineDeviceDataSelected = data;
            isDeviceName = true;
            break;
          }
        }
        if (isDeviceName) {
          if (offlineDeviceDataSelected.deviceStatus == 0) {
            deviceId = offlineDeviceDataSelected.deviceId;
            settingId = offlineDeviceDataSelected.settingId;
            facilityId = offlineDeviceDataSelected.facilityId;
            addDeviceAPI();
          } else {
            // offline device just active
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          }
        } else {
          pref.setString(Sharepref.serialNo, _deviceName);
          newDeviceAdding();
        }
      }
    } else {
      if (_deviceName.isEmpty) {
        context.showToast("Please enter device name");
      } else if(!_validateDeviceName){
        setState(() {
          _validateDeviceName = false;
        });
        context.showToast("Special characters are not allowed");
      }else newDeviceAdding();
  }
  }
  Future<void> newDeviceAdding() async {
    settingId = 0;
    facilityId = 0;
    for (var data in widget.tabletSettingData) {
    if (_textEditingControllerSettings.text == data.settingName) {
    settingId = data.id;
    break;
    }
    }
    for (var data in widget.facilityListData) {
    if (_textEditingControllerFacility.text == data.facilityName) {
    facilityId = data.facilityId;
    break;
    }
    }
    if(settingId == 0){
    context.showToast("Invalid device settings");

    }else if(facilityId == 0){
    context.showToast("Invalid facility");

    }else {
    addDeviceAPI();
    }
    }

  Future<void> addDeviceAPI() async {
    await _isProgressLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> registerBody = HashMap();
    registerBody['deviceType'] = pref.getString(Sharepref.platformId);
    registerBody['deviceName'] = _deviceName;
    registerBody['serialNumber'] = pref.getString(Sharepref.serialNo);
    registerBody['IMEINumber'] = "";
    registerBody['status'] = 1;
    registerBody['settingsId'] = settingId;
    registerBody['deviceId'] = deviceId;
    registerBody['facilityId'] = facilityId;

    RegisterDeviceResponse registerDeviceResponse = await ApiService()
        .registerDeviceForApp(pref, registerBody) as RegisterDeviceResponse;
    if (registerDeviceResponse.responseCode == 1) {
      await _isProgressLoading.hide();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      await _isProgressLoading.hide();
      context.showToast(registerDeviceResponse.responseMessage!);
    }
  }
  }
