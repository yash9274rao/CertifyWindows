

class DeviceSettingsData {
  final String doNotSyncMembers;
  final String? syncMemberGroup;
  final String? groupId;
  final String navigationBar;
  final String? multipleScanMode;
  final String? deviceMasterCode;
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
      required this.allowMultilingual,
      required this.debugMode});

  factory DeviceSettingsData.fromJson(Map<String, dynamic> json) {
    return DeviceSettingsData(

        doNotSyncMembers: json['doNotSyncMembers'],
        syncMemberGroup: json['syncMemberGroup'] ?? "Invalid QR Code",
        groupId: json['groupId'],
        navigationBar: json['navigationBar'],
        multipleScanMode: json['multipleScanMode'],
        deviceMasterCode: json['deviceMasterCode'] ?? "Invalid QR Code",
        allowMultilingual: json['allowMultilingual'],
        debugMode: json['debugMode']);
  }
}
