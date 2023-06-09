class ResponseDataVolunteer {
  final String id;

  const ResponseDataVolunteer(
      {required this.id,
      });

  factory ResponseDataVolunteer.fromJson(Map<String, dynamic> json) {
    return ResponseDataVolunteer(
      id: json['id'] ?? "",
       );
  }
}
