import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/gamification/bindings/gamification_binding.dart';
import '../modules/gamification/views/gamification_view.dart';
import '../modules/charts/bindings/charts_binding.dart';
import '../modules/charts/views/charts_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      // Choose one of these dramatic transitions to test:
      transition: Transition.fadeIn, // Simple fade-in effect
      // transition: Transition.rightToLeft, // Slide from right to left
      // transition: Transition.leftToRight, // Slide from left to right
      curve: Curves.easeInOut, // Smooth transition curve
      transitionDuration:
          Duration(milliseconds: 500), // Longer duration for effect
    ),
    GetPage(
      name: _Paths.GAMIFICATION,
      page: () => const GamificationView(),
      binding: GamificationBinding(),
      // Choose one of these dramatic transitions to test:
      transition: Transition.rightToLeftWithFade, // Slide + fade combo
      // transition: Transition.zoom, // Zoom in effect
      // transition: Transition.size, // Size scaling effect
      // transition: Transition.downToUp, // Slide up from bottom
      // transition: Transition.leftToRightWithFade, // Slide from left with fade
      // transition: Transition.cupertino, // iOS style slide
      transitionDuration: Duration(milliseconds: 800), // Even longer duration
      curve: Curves.elasticOut, // Bouncy animation curve
      // Pre-load the binding to reduce initialization time
      preventDuplicates: true,
    ),
    GetPage(
      name: _Paths.CHARTS,
      page: () => const ChartsView(),
      binding: ChartsBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    ),
  ];
}
