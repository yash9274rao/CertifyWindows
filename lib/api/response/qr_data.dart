class QrData {
  late String qrCodeId;

  late String name;

  late bool isValid;

  set setName(String name) {
    this.name = name;
  }

  String get getName => name;

  set setQrCodeID(String qrCodeId) {
    this.qrCodeId = qrCodeId;
  }

  String get getQrCodeID => qrCodeId;

  set setIsValid(bool isValid) {
    this.isValid = isValid;
  }

  bool get getIsValid => isValid;
}
