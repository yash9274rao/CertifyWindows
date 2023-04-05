class ResponseDataToken {
  final String access_token;
  final String token_type;
  final int expires_in;

  const ResponseDataToken(
      {required this.access_token,
      required this.token_type,
      required this.expires_in});

  factory ResponseDataToken.fromJson(Map<String, dynamic> json) {
    return ResponseDataToken(
      access_token: json['access_token'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
    );
  }
}
