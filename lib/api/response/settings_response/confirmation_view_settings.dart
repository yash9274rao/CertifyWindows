

class ConfirmationViewSettings {
  final String enableConfirmationScreen;
  final String? normalViewLine1;
  final String? normalViewLine2;
  final String enableHomeScreen;
  final String? showVaccinationIndicator;
  final String? showNonVaccinationIndicator;

  const ConfirmationViewSettings(
      {
      required this.enableConfirmationScreen,
      required this.normalViewLine1,
      required this.normalViewLine2,
      required this.enableHomeScreen,
      required this.showVaccinationIndicator,
      required this.showNonVaccinationIndicator});

  factory ConfirmationViewSettings.fromJson(Map<String, dynamic> json) {
    return ConfirmationViewSettings(

        enableConfirmationScreen: json['enableConfirmationScreen'],
        normalViewLine1: json['normalViewLine1'] ?? "",
        normalViewLine2: json['normalViewLine2'],
        enableHomeScreen: json['enableHomeScreen'] ?? "1",
        showVaccinationIndicator: json['showVaccinationIndicator'] ?? "2",
        showNonVaccinationIndicator: json['showNonVaccinationIndicator'] ?? "");
  }
}
