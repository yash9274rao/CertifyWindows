class ResponseDataToken {
  final String access_token;
  final String token_type;
  final int expires_in;
  final String institutionID;
  final String command;
  final String expiryTime;

  const ResponseDataToken(
      {required this.access_token,
      required this.token_type,
      required this.expires_in,
      required this.institutionID,
      required this.command,
      required this.expiryTime});

  factory ResponseDataToken.fromJson(Map<String, dynamic> json) {
    return ResponseDataToken(
      access_token: json['access_token'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
      institutionID: json['InstitutionID'] ?? "",
      command: json['command'] ?? "",
      expiryTime: json['.expires']
    );
  }
}
