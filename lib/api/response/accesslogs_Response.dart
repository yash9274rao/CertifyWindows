class AccesslogsResponse {
  final int responseCode;
  final int responseSubCode;
  final String responseMessage;

  const AccesslogsResponse(
      {required this.responseCode,
        required this.responseSubCode,
        required this.responseMessage});

  factory AccesslogsResponse.fromJson(Map<String, dynamic> json) {
    return AccesslogsResponse(
      responseCode: json['responseCode'],
      responseSubCode: json['responseSubCode'],
      responseMessage: json['responseMessage'],
    );
  }
}