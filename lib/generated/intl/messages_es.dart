// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(name) => "por ${name}";

  static String m1(date) => "creado ${date}";

  static String m2(count) =>
      "${Intl.plural(count, one: '${count} voto', other: '${count} votos')}";

  static String m3(locale) => "${Intl.select(locale, {
            'ar': 'عربي',
            'en': 'English',
            'es': 'Español',
            'other': '-',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageHomeDrawerHeader": MessageLookupByLibrary.simpleMessage("Recetas"),
        "pageHomeDrawerListTileSettings":
            MessageLookupByLibrary.simpleMessage("Ajustes"),
        "pageHomeRecipeAuthor": m0,
        "pageHomeRecipeCreated": m1,
        "pageHomeRecipeFriedEggsDescription":
            MessageLookupByLibrary.simpleMessage(
                "Una comida llena de proteínas y minerales."),
        "pageHomeRecipeFriedEggsName":
            MessageLookupByLibrary.simpleMessage("Huevos fritos"),
        "pageHomeRecipeRiceDescription": MessageLookupByLibrary.simpleMessage(
            "Arroz con verduras y frijoles. Una comida nutritiva alta en fibra."),
        "pageHomeRecipeRiceName": MessageLookupByLibrary.simpleMessage("Arroz"),
        "pageHomeRecipeSaladDescription": MessageLookupByLibrary.simpleMessage(
            "Ensalada de verduras frescas llena de vitaminas, fibra y minerales."),
        "pageHomeRecipeSaladName":
            MessageLookupByLibrary.simpleMessage("Ensalada"),
        "pageHomeRecipeVotes": m2,
        "pageHomeTitle": MessageLookupByLibrary.simpleMessage("Recetas"),
        "pageSettingsInputLanguage": m3,
        "pageSettingsTitle": MessageLookupByLibrary.simpleMessage("Ajustes")
      };
}
