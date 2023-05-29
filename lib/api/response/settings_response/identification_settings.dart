
class IdentificationSettings {
  final String enableQRCodeScanner;
  final String? enableAnonymousQRCode;
  final String? enableRFIDScanner;
  final String identificationTimeout;
  final String? enableQRCode;
  final String enableOfflineQRCode;
  final String? enableVendorQR;
  final String? enableVisitorQR;
  final String? visitorMode;
  final String? enableVisitorCheckout;
  final String? checkInMode;
  final String? enableVolunteerQR;

  const IdentificationSettings(
      {
      required this.enableQRCodeScanner,
      required this.enableAnonymousQRCode,
      required this.enableRFIDScanner,
      required this.identificationTimeout,
      required this.enableQRCode,
      required this.enableOfflineQRCode,
        required this.enableVendorQR,
        required this.enableVisitorQR,
        required this.visitorMode,
        required this.enableVisitorCheckout,
        required this.checkInMode,
        required this.enableVolunteerQR
      });

  factory IdentificationSettings.fromJson(Map<String, dynamic> json) {
    return IdentificationSettings(

        enableQRCodeScanner: json['enableQRCodeScanner'],
        enableAnonymousQRCode: json['enableAnonymousQRCode'],
        enableRFIDScanner: json['enableRFIDScanner'] ?? "",
        identificationTimeout: json['identificationTimeout'],
        enableQRCode: json['enableQRCode'] ?? "1",
        enableOfflineQRCode: json['enableOfflineQRCode'] ?? "2",
        enableVendorQR: json['enableVendorQR'] ?? "",
        enableVisitorQR: json['enableVisitorQR'],
        visitorMode: json['visitorMode'] ?? "",
        checkInMode: json['CheckinMode'] ?? "",
        enableVolunteerQR: json['enableVolunteerQR'] ?? "",
        enableVisitorCheckout: json['enableVisitorCheckout']
    );
  }
}
