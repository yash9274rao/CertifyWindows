

class AccessControlSettings {
  final String enableAutomaticDoors;
  final String? allowAnonymous;
  final String? enableAccessControl;
  final String loggingMode;
  final String? validAccessOption;
  final String attendanceMode;
  final String? enableMobileAccessCard;


  const AccessControlSettings({
    required this.enableAutomaticDoors,
    required this.allowAnonymous,
    required this.enableAccessControl,
    required this.loggingMode,
    required this.validAccessOption,
    required this.attendanceMode,
    required this.enableMobileAccessCard
  });

  factory AccessControlSettings.fromJson(Map<String, dynamic> json) {
    return AccessControlSettings(
        enableAutomaticDoors: json['enableAutomaticDoors'],
        allowAnonymous: json['allowAnonymous'],
        enableAccessControl: json['enableAccessControl'] ?? "",
        loggingMode: json['loggingMode'],
        validAccessOption: json['validAccessOption'] ?? "1",
        attendanceMode: json['attendanceMode'] ?? "2",
        enableMobileAccessCard: json['enableVendorQR'] ?? "");
  }
}
