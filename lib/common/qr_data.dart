class QrData {
  late String qrCodeId = "";
  late bool isValid = false;
  late String id = "0";
  late String firstName;
  late String lastName ="";
  late String memberId ="";
  late String accessId ="";
  late int trqStatus = 0;
  late int memberTypeId = 0;
  late String faceTemplate ="";
  late String memberTypeName="";
  late int isVisitor = 0;

  set setQrCodeID(String qrCodeId) {
    this.qrCodeId = qrCodeId;
  }

  String get getQrCodeID => qrCodeId;

  set setIsValid(bool isValid) {
    this.isValid = isValid;
  }

  bool get getIsValid => isValid;

  set setId(String id) {
    this.id = id;
  }

  String get getId => id;

  set setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String get getFirstName => firstName;

  set setLastName(String lastName) {
    this.lastName = lastName;
  }

  String get getLastName => firstName;

  set setMemberId(String memberId) {
    this.memberId = memberId;
  }

  String get getMemberId => memberId;

  set setAccessId(String accessId) {
    this.accessId = accessId;
  }

  String get getAccessId => accessId;

  set setTrqStatus(int trqStatus) {
    this.trqStatus = trqStatus;
  }

  int get getTrqStatus => trqStatus;

  set setMemberTypeId(int memberTypeId) {
    this.memberTypeId = memberTypeId;
  }

  int get getMemberTypeId => memberTypeId;

  set setMemberTypeName(String memberTypeName) {
    this.memberTypeName = memberTypeName;
  }

  String get getMemberTypeName => memberTypeName;

  set setFaceTemplate(String faceTemplate) {
    this.faceTemplate = faceTemplate;
  }

  String get getFaceTemplate => faceTemplate;

  set setIsVisitor(int isVisitor) {
    this.isVisitor = isVisitor;
  }

  int get getisVisitor => isVisitor;
}
