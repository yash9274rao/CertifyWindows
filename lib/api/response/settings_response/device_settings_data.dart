

class DeviceSettingsData {
  final String doNotSyncMembers;
  final String? syncMemberGroup;
  final String? groupId;
  final String navigationBar;
  final String? multipleScanMode;
  final String? deviceMasterCode;
  final int primaryLanguageId;
  final String? allowMultilingual;
  final String? debugMode;

  const DeviceSettingsData(
      {
      required this.doNotSyncMembers,
      required this.syncMemberGroup,
      required this.groupId,
      required this.navigationBar,
      required this.multipleScanMode,
      required this.deviceMasterCode,
      required this.primaryLanguageId,
      required this.allowMultilingual,
      required this.debugMode});

  factory DeviceSettingsData.fromJson(Map<String, dynamic> json) {
    return DeviceSettingsData(

        doNotSyncMembers: json['doNotSyncMembers'],
        syncMemberGroup: json['syncMemberGroup'] ?? "Invalid QRCode",
        groupId: json['groupId'],
        navigationBar: json['navigationBar'],
        multipleScanMode: json['multipleScanMode'],
        deviceMasterCode: json['deviceMasterCode'] ?? "Invalid QRCode",
        primaryLanguageId: json['primaryLanguageId'],
        allowMultilingual: json['allowMultilingual'],
        debugMode: json['debugMode']);
  }
}
