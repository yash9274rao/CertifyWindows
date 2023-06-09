// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(name) => "بواسطة ${name}";

  static String m1(date) => "خلقت ${date}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'لا يوجد تصويتات', one: 'صوت ${count}', two: 'صوت ${count}', few: 'أصوات ${count}', many: 'أصوات ${count}', other: 'صوت ${count}')}";

  static String m3(locale) => "${Intl.select(locale, {
            'ar': 'عربي',
            'en': 'English',
            'es': 'Español',
            'other': '-',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "pageHomeDrawerHeader": MessageLookupByLibrary.simpleMessage("وصفات"),
        "pageHomeDrawerListTileSettings":
            MessageLookupByLibrary.simpleMessage("إعدادات"),
        "pageHomeRecipeAuthor": m0,
        "pageHomeRecipeCreated": m1,
        "pageHomeRecipeFriedEggsDescription":
            MessageLookupByLibrary.simpleMessage(
                "وجبة غنية بالبروتينات والمعادن."),
        "pageHomeRecipeFriedEggsName":
            MessageLookupByLibrary.simpleMessage("البيض المقلي"),
        "pageHomeRecipeRiceDescription": MessageLookupByLibrary.simpleMessage(
            "أرز بالخضار والفاصوليا. وجبة مغذية غنية بالألياف."),
        "pageHomeRecipeRiceName": MessageLookupByLibrary.simpleMessage("أرز"),
        "pageHomeRecipeSaladDescription": MessageLookupByLibrary.simpleMessage(
            "سلطة خضار طازجة مليئة بالفيتامينات والألياف والمعادن."),
        "pageHomeRecipeSaladName": MessageLookupByLibrary.simpleMessage("سلطة"),
        "pageHomeRecipeVotes": m2,
        "pageHomeTitle": MessageLookupByLibrary.simpleMessage("وصفات"),
        "pageSettingsInputLanguage": m3,
        "pageSettingsTitle": MessageLookupByLibrary.simpleMessage("إعدادات")
      };
}
