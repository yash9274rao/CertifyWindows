
import 'package:certify_me_kiosk/api/response/register_device/response_data.dart';

class RegisterDeviceResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;
  final List<FacilityListData>? facilityListData;
  const RegisterDeviceResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
        required this.facilityListData,});

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) {
    return RegisterDeviceResponse(
      responseCode: json['responseCode'],
      responseSubCode: json['responseSubCode'],
      responseMessage:
          json['responseMessage'] ?? "",
      facilityListData :json['responseData'] == null? []: List.from(json['FacilityListData']).map((e) => FacilityListData.fromJson(e)).toList(),
    );
  }
}
