class HomePageSettings {
  final String logo;
  final String? line1;
  final String? line2;
  final String enableHomeScreen;
  final String? viewIntervalDelay;
  final String? enableTextOnly;
  final String homeText;
  final String colourCodeForButton;
  final String colourCodeForTextButton;

  const HomePageSettings(
      {required this.logo,
      required this.line1,
      required this.line2,
      required this.enableHomeScreen,
      required this.viewIntervalDelay,
      required this.enableTextOnly,
      required this.homeText,
      required this.colourCodeForButton,
      required this.colourCodeForTextButton});

  factory HomePageSettings.fromJson(Map<String, dynamic> json) {
    return HomePageSettings(
        logo: json['logo'],
        line1: json['line1'] ?? "",
        line2: json['line2'] ?? "",
        enableHomeScreen: json['enableHomeScreen'] ?? "1",
        viewIntervalDelay: json['viewIntervalDelay'] ?? "2",
        enableTextOnly: json['enableTextOnly'] ?? "",
        homeText: json['homeText'],
        colourCodeForButton: json['colourCodeForButton'] ?? "0xff3A95EF",
        colourCodeForTextButton: json['colourCodeForTextButton'] ?? "0xffEBF1F8");
  }
}
