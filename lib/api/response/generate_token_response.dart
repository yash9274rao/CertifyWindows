class GenerateTokenResponse {
  final String access_token;
  final String token_type;


  const GenerateTokenResponse(
      {required this.access_token,
      required this.token_type,
     });

  factory GenerateTokenResponse.fromJson(Map<String, dynamic> json) {
    return GenerateTokenResponse(
      access_token: json['access_token'],
      token_type: json['token_type']
    );
  }
}
