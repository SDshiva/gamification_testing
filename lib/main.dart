import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/config/app_theme.dart';
import 'app/localization/app_translations.dart';
import 'app/localization/localization_keys.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: LocalizationKeys.appTitle.tr,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Localization setup
      translations: AppTranslations(),
      locale: Locale('en', 'US'), // Default language
      fallbackLocale: Locale('en', 'US'), // Fallback language
      debugShowCheckedModeBanner: false,
    ),
  );
}
