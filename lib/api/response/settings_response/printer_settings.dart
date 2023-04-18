
class PrinterSettings {
  final String enableWBPrint;
  final String? enableUSBPrint;
  final String? printAllScan;
  final String printAccessCard;
  final String? printQRCode;
  final String printFace;
  final String? printName;
  final String? unidentifiedPrintText;
  final String? printIndicatorForQR;
  final String? defaultResultPrint;


  const PrinterSettings(
      {
      required this.enableWBPrint,
      required this.enableUSBPrint,
      required this.printAllScan,
      required this.printAccessCard,
      required this.printQRCode,
      required this.printFace,
        required this.printName,
        required this.unidentifiedPrintText,
        required this.printIndicatorForQR,
        required this.defaultResultPrint
      });

  factory PrinterSettings.fromJson(Map<String, dynamic> json) {
    return PrinterSettings(
        enableWBPrint: json['enableWBPrint'],
        enableUSBPrint: json['enableUSBPrint'],
        printAllScan: json['printAllScan'] ?? "",
        printAccessCard: json['printAccessCard'],
        printQRCode: json['printQRCode'] ?? "1",
        printFace: json['printFace'] ?? "2",
        printName: json['printName'] ?? "",
        unidentifiedPrintText: json['unidentifiedPrintText'],
        printIndicatorForQR: json['printIndicatorForQR'] ?? "",
        defaultResultPrint: json['defaultResultPrint'] );
  }
}
