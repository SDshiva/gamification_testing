import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/charts_controller.dart';
import '../widgets/line_chart_widget.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/area_chart_widget.dart';
import '../widgets/scatter_chart_widget.dart';
import '../widgets/donut_chart_widget.dart';
import '../widgets/radar_chart_widget.dart';
import '../widgets/bubble_chart_widget.dart';

class ChartsView extends GetView<ChartsController> {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts Testing'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => controller.refreshData(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: GetBuilder<ChartsController>(
        builder: (controller) => Column(
          children: [
            // Chart selector tabs
            Container(
              height: 50,
              margin: const EdgeInsets.all(8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.chartTypes.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final isSelected =
                        controller.selectedChartIndex.value == index;
                    return InkWell(
                      onTap: () => controller.changeChart(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.chartTypes[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            // Chart display area
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(() =>
                    _buildSelectedChart(controller.selectedChartIndex.value)),
              ),
            ),

            // Chart information
            Obx(() => Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller
                            .chartTypes[controller.selectedChartIndex.value],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getChartDescription(
                            controller.selectedChartIndex.value),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedChart(int index) {
    switch (index) {
      case 0:
        return const LineChartWidget();
      case 1:
        return const BarChartWidget();
      case 2:
        return const PieChartWidget();
      case 3:
        return const AreaChartWidget();
      case 4:
        return const ScatterChartWidget();
      case 5:
        return const DonutChartWidget();
      case 6:
        return const RadarChartWidget();
      case 7:
        return const BubbleChartWidget();
      default:
        return const LineChartWidget();
    }
  }

  String _getChartDescription(int index) {
    switch (index) {
      case 0:
        return 'Line charts show trends over time. Perfect for tracking progress, performance metrics, or any continuous data.';
      case 1:
        return 'Bar charts compare different categories. Great for showing comparisons between different items or groups.';
      case 2:
        return 'Pie charts show parts of a whole. Ideal for displaying percentages or proportions of different categories.';
      case 3:
        return 'Area charts are like line charts but with filled areas. Good for showing cumulative data or volume over time.';
      case 4:
        return 'Scatter plots show relationships between two variables. Useful for finding correlations in your data.';
      case 5:
        return 'Donut charts are pie charts with a hollow center. They provide more space for additional information.';
      case 6:
        return 'Radar charts show multiple variables on axes radiating from a center point. Great for comparing profiles.';
      case 7:
        return 'Bubble charts add a third dimension to scatter plots using bubble size. Perfect for complex data relationships.';
      default:
        return 'Select a chart type to see its description.';
    }
  }
}
