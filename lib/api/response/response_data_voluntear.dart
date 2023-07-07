class ResponseDataVolunteer {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final List<VolunteerSchedulingDetailList>? volunteerList;

  const ResponseDataVolunteer(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.volunteerList});

  factory ResponseDataVolunteer.fromJson(Map<String, dynamic> json) {
    return ResponseDataVolunteer(
      id: json['id'] ?? "",
      firstName: json['firstName'] ?? "",
      middleName: json['middleName'] ?? "",
      lastName: json['lastName'] ?? "",
      volunteerList: json['VolunteerSchedulingDetailList'] == null
          ? []
          : List.from(json['VolunteerSchedulingDetailList'])
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

  const VolunteerSchedulingDetailList(
      {required this.scheduleId,
      required this.scheduleTitle,
      required this.fromTime,
      required this.toTime});

  factory VolunteerSchedulingDetailList.fromJson(Map<String, dynamic> json) {
    return VolunteerSchedulingDetailList(
      scheduleId: json['ScheduleId'],
      scheduleTitle: json['ScheduleTitle'],
      fromTime: json['FromTime'],
      toTime: json['ToTime'],
    );
  }
}
