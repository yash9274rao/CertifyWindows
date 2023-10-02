class ResponseDataQrCode {
  final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String memberId;
  final String accessId;
  final int trqStatus;
  final int memberTypeId;
  final String faceTemplate;
  final String memberTypeName;
  final int isVisitor;
  final int scheduleId;
  final String eventName;
  final String fromDate;
  final String toDate;
  final int documentType;


  const ResponseDataQrCode(
      {required this.id,
      required this.firstName,
      required this.lastName,
        required this.middleName,
      required this.memberId,
      required this.accessId,
      required this.trqStatus,
      required this.memberTypeId,
      required this.faceTemplate,
      required this.memberTypeName,
      required this.isVisitor,
        required this.scheduleId,
        required this.eventName,
        required this.fromDate,
        required this.toDate,
        required this.documentType,
      });

  factory ResponseDataQrCode.fromJson(Map<String, dynamic> json) {
    return ResponseDataQrCode(
        id: json['id'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        middleName: json['middleName'] ?? "",
        memberId: json['memberId'] ?? "",
        accessId: json['accessId'] ?? "",
        trqStatus: json['trqStatus'] ?? 0,
        memberTypeId: json['memberTypeId'] ?? 0,
        faceTemplate: json['faceTemplate'] ?? "",
        memberTypeName: json['memberTypeName'] ?? "",
        isVisitor: json['isVisitor'] ?? 0,
        scheduleId: json['scheduleId'] ?? 0,
        eventName: json['eventName'] ?? "",
        fromDate: json['fromDate'] ?? "",
        toDate: json['toDate'] ?? "",
        documentType: json['documentType'] ?? 0);
  }
}
