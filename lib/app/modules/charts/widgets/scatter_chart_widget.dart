import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/charts_controller.dart';

class ScatterChartWidget extends StatelessWidget {
  const ScatterChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Data Correlation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter:
                      ScatterChartPainter(controller.scatterPlotData.value),
                )),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Variable X →',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('↑ Variable Y',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class ScatterChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  ScatterChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 5; i++) {
      final x = (i / 5) * size.width;
      final y = (i / 5) * size.height;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw scatter points
    for (final point in data) {
      final paint = Paint()
        ..color = Colors.red.withOpacity(0.7)
        ..style = PaintingStyle.fill;

      final x = (point['x'] ?? 0.0) / 100 * size.width;
      final y = size.height - ((point['y'] ?? 0.0) / 100) * size.height;
      final radius = (point['size'] ?? 5.0) / 2;

      canvas.drawCircle(Offset(x, y), radius, paint);

      // Add border to points
      final borderPaint = Paint()
        ..color = Colors.purple
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(Offset(x, y), radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
