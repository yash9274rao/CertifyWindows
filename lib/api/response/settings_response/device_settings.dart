import 'access_control_settings.dart';
import 'confirmation_view_settings.dart';
import 'device_settings_data.dart';
import 'home_page_settings.dart';
import 'identification_settings.dart';
import 'printer_settings.dart';

class DeviceSettings {
  final DeviceSettingsData? deviceSettings;
  final HomePageSettings? homePageSettings;
  final ConfirmationViewSettings? confirmationViewSettings;
  final IdentificationSettings identificationSettings;
  final AccessControlSettings? accessControlSettings;
  final PrinterSettings? printerSettings;

  const DeviceSettings({required this.deviceSettings,
    required this.homePageSettings,
    required this.confirmationViewSettings,
    required this.identificationSettings,
    required this.accessControlSettings,
    required this.printerSettings});

  factory DeviceSettings.fromJson(Map<String, dynamic> json) {
    return DeviceSettings(
        deviceSettings:
        DeviceSettingsData.fromJson(json['DeviceSettings'] ?? {}),
        homePageSettings:
        HomePageSettings.fromJson(json['HomePageView'] ?? {}),
        confirmationViewSettings:
        ConfirmationViewSettings.fromJson(json['ConfirmationView'] ?? {}),
        identificationSettings:
        IdentificationSettings.fromJson(json['IdentificationSettings'] ?? {}),
        accessControlSettings:
        AccessControlSettings.fromJson(json['AccessControl'] ?? {}),
        printerSettings:
        PrinterSettings.fromJson(json['PrinterSettings'] ?? {}));
  }
}
