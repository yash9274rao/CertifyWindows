import 'dart:ffi';

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
        enableMembersVisitors:json['enableMembersVisitors'] ?? "",
      enableVendors:json['enableVendors'] ?? "",
      enableVolunteers:json['enableVolunteers'] ?? "",
    );


  }
}
