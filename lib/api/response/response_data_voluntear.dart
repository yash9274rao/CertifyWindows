class ResponseDataVolunteer {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final int documentType;
  final List<VolunteerSchedulingDetailList>? volunteerList;

  const ResponseDataVolunteer(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.documentType,
      required this.volunteerList});

  factory ResponseDataVolunteer.fromJson(Map<String, dynamic> json) {
    return ResponseDataVolunteer(
      id: json['id'] ?? "",
      firstName: json['firstName'] ?? "",
      middleName: json['middleName'] ?? "",
      lastName: json['lastName'] ?? "",
      documentType: json['documentType'] ?? 0,
      volunteerList: json['volunteerSchedulingDetailList'] == null
          ? []
          : List.from(json['volunteerSchedulingDetailList'])
              .map((e) => VolunteerSchedulingDetailList.fromJson(e))
              .toList(),
    );
  }
}

class VolunteerSchedulingDetailList {
  final int scheduleId;
  final String scheduleTitle;
  final String fromTime;
  final String toTime;
  final int status;
  final String checkIndate;
  final String checkOutDate;


  const VolunteerSchedulingDetailList(
      {required this.scheduleId,
      required this.scheduleTitle,
      required this.fromTime,
      required this.toTime,
        required this.status,
        required this.checkIndate,
        required this.checkOutDate});

  factory VolunteerSchedulingDetailList.fromJson(Map<String, dynamic> json) {
    return VolunteerSchedulingDetailList(
      scheduleId: json['scheduleId'],
      scheduleTitle: json['scheduleTitle'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      status: json['status'],
      checkIndate: json['checkIndate'],
      checkOutDate: json['checkOutDate'],
    );
  }
}
