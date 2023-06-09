
class BufferTimeSettings {
  final String? enableBufferTime;
  final String? allowBufferTime;
  final bool? enableMembersVisitors;
  final bool? enableVendors;
  final bool? enableVolunteers;

  const BufferTimeSettings(
      {
        required this.enableBufferTime,
        required this.allowBufferTime,
        required this.enableMembersVisitors,
        required this.enableVendors,
        required this.enableVolunteers,
       });

  factory BufferTimeSettings.fromJson(Map<String, dynamic> json) {
    return BufferTimeSettings(

        enableBufferTime: json['enableBufferTime'] ?? "",
        allowBufferTime:json['allowBufferTime'] ?? "",
        enableMembersVisitors:json['enableMembersVisitors'] ?? false,
      enableVendors:json['enableVendors'] ?? false,
      enableVolunteers:json['enableVolunteers'] ?? false,
    );


  }
}
