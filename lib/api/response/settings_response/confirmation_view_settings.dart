

class ConfirmationViewSettings {
  final String enableConfirmationScreen;
  final String? normalViewLine1;
  final String? normalViewLine2;
  final String enableHomeScreen;
  final String? showVaccinationIndicator;
  final String? showNonVaccinationIndicator;
  final String? viewDelayAboveThreshold;
  final String? viewDelay;
  final String? mainText;
  final String? subText;
  const ConfirmationViewSettings(
      {
        required this.enableConfirmationScreen,
      required this.viewDelayAboveThreshold,
      required this.normalViewLine1,
      required this.normalViewLine2,
        required this.viewDelay,
      required this.enableHomeScreen,
      required this.showVaccinationIndicator,
        required this.mainText,
        required this.subText,
      required this.showNonVaccinationIndicator});

  factory ConfirmationViewSettings.fromJson(Map<String, dynamic> json) {
    return ConfirmationViewSettings(
        viewDelayAboveThreshold:json['viewDelayAboveThreshold'] ?? "",
        enableConfirmationScreen: json['enableConfirmationScreen'],
        normalViewLine1: json['normalViewLine1'] ?? "",
        normalViewLine2: json['normalViewLine2'] ?? "",
        enableHomeScreen: json['enableHomeScreen'] ?? "1",
        showVaccinationIndicator: json['showVaccinationIndicator'] ?? "2",
        viewDelay:json['viewDelay'] ?? "",
        mainText:json['MainText'] ?? "",
        subText:json['SubText'] ?? "",
        showNonVaccinationIndicator: json['showNonVaccinationIndicator'] ?? "");

  }
}
