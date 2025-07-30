import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ChartsController extends GetxController {
  var selectedChartIndex = 0.obs;

  final chartTypes = [
    'Line Chart',
    'Bar Chart',
    'Pie Chart',
    'Area Chart',
    'Scatter Plot',
    'Donut Chart',
    'Radar Chart',
    'Bubble Chart',
  ];

  // Sample data for different chart types
  var lineChartData = <Map<String, dynamic>>[].obs;
  var barChartData = <Map<String, dynamic>>[].obs;
  var pieChartData = <Map<String, dynamic>>[].obs;
  var areaChartData = <Map<String, dynamic>>[].obs;
  var scatterPlotData = <Map<String, dynamic>>[].obs;
  var radarChartData = <String, dynamic>{}.obs;
  var bubbleChartData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateSampleData();
  }

  void _generateSampleData() {
    final random = math.Random();

    // Line chart data
    lineChartData.value = List.generate(
        10,
        (index) => {
              'x': index.toDouble(),
              'y': 20.0 + random.nextDouble() * 80.0,
            });

    // Bar chart data
    barChartData.value = List.generate(
        7,
        (index) => {
              'label': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
              'value': 10.0 + random.nextDouble() * 90.0,
              'color': [
                0xFF2196F3,
                0xFF4CAF50,
                0xFFFF9800,
                0xFFF44336,
                0xFF9C27B0,
                0xFF00BCD4,
                0xFFFFEB3B
              ][index],
            });

    // Pie chart data
    pieChartData.value = [
      {'label': 'Completed', 'value': 45.0, 'color': 0xFF4CAF50},
      {'label': 'In Progress', 'value': 30.0, 'color': 0xFF2196F3},
      {'label': 'Pending', 'value': 15.0, 'color': 0xFFFF9800},
      {'label': 'Cancelled', 'value': 10.0, 'color': 0xFFF44336},
    ];

    // Area chart data
    areaChartData.value = List.generate(
        10,
        (index) => {
              'x': index.toDouble(),
              'y': 30.0 + random.nextDouble() * 40.0,
            });

    // Scatter plot data
    scatterPlotData.value = List.generate(
        20,
        (index) => {
              'x': random.nextDouble() * 100,
              'y': random.nextDouble() * 100,
              'size': 5.0 + random.nextDouble() * 10.0,
              'color': [
                0xFF2196F3,
                0xFF4CAF50,
                0xFFFF9800,
                0xFFF44336
              ][random.nextInt(4)],
            });

    // Radar chart data
    radarChartData.value = {
      'labels': [
        'Speed',
        'Accuracy',
        'Creativity',
        'Teamwork',
        'Leadership',
        'Problem Solving'
      ],
      'values': [85.0, 70.0, 90.0, 75.0, 60.0, 95.0],
    };

    // Bubble chart data
    bubbleChartData.value = List.generate(
        8,
        (index) => {
              'x': 10.0 + random.nextDouble() * 80.0,
              'y': 10.0 + random.nextDouble() * 80.0,
              'size': 5.0 + random.nextDouble() * 15.0,
              'label': ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'][index],
              'color': [
                0xFF2196F3,
                0xFF4CAF50,
                0xFFFF9800,
                0xFFF44336,
                0xFF9C27B0,
                0xFF00BCD4,
                0xFFFFEB3B,
                0xFF795548
              ][index],
            });
  }

  void changeChart(int index) {
    debugPrint('Changing chart to index: $index');
    selectedChartIndex.value = index;
  }

  void refreshData() {
    _generateSampleData();
  }
}
