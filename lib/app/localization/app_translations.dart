import 'package:get/get.dart';
import 'translations/en_us_translations.dart';
import 'translations/bn_bd_translations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ...EnglishTranslations().keys,
        ...BengaliTranslations().keys,
      };
}
