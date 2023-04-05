class ResponseDataValidateVendor {
  final String vendorImage;
  final String vendorName;

  const ResponseDataValidateVendor(
      {required this.vendorImage, required this.vendorName});

  factory ResponseDataValidateVendor.fromJson(Map<String, dynamic> json) {
    return ResponseDataValidateVendor(
        vendorImage: json['vendorImage'] ?? "",
        vendorName: json['vendorName'] ?? "");
  }
}
