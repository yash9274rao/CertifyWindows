class ActivateApplicationResponse {
  final int responseCode;
  final int responseSubCode;
  final String responseMessage;

  const ActivateApplicationResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage});

  factory ActivateApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ActivateApplicationResponse(
      responseCode: json['responseCode'],
      responseSubCode: json['responseSubCode'],
      responseMessage: json['responseMessage'],
    );
  }
}
