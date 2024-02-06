class ResponseDataValidateVendor {
  final String vendorImage;
  final String vendorName;
  final String appointmentId;

  const ResponseDataValidateVendor(
      {required this.vendorImage, required this.vendorName, required this.appointmentId});

  factory ResponseDataValidateVendor.fromJson(Map<String, dynamic> json) {
    return ResponseDataValidateVendor(
        vendorImage: json['vendorImage'] ?? "",
        vendorName: json['vendorName'] ?? "",
        appointmentId: json['appointmentId'] ?? "");
  }
}
