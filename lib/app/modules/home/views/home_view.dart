import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../localization/localization_keys.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationKeys.appName.tr),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videogame_asset,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 24),
              Text(
                LocalizationKeys.welcomeTitle.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                LocalizationKeys.welcomeSubtitle.tr,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  // Navigate with optimized route
                  Get.toNamed(Routes.GAMIFICATION);
                },
                icon: Icon(Icons.play_arrow),
                label: Text(LocalizationKeys.startGamification.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    LocalizationKeys.quickDemo.tr,
                    LocalizationKeys.tutorialMessage.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                icon: Icon(Icons.help_outline),
                label: Text(LocalizationKeys.howItWorks.tr),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Get.toNamed(Routes.CHARTS);
                },
                icon: Icon(Icons.bar_chart),
                label: Text('Test Charts'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
