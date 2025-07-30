import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/charts_controller.dart';

class DonutChartWidget extends StatelessWidget {
  const DonutChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Performance Metrics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => CustomPaint(
                      size: const Size(200, 200),
                      painter: DonutChartPainter(controller.pieChartData.value),
                    )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Obx(() => Text(
                          '${controller.pieChartData.value.fold(0.0, (sum, item) => sum + item['value']).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => Wrap(
                spacing: 16,
                runSpacing: 8,
                children: controller.pieChartData.value
                    .map(
                      (item) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(item['color']),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['label'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  DonutChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2 - 10;
    final innerRadius = outerRadius * 0.6;

    double startAngle = -math.pi / 2;

    for (final item in data) {
      final paint = Paint()
        ..color = Color(item['color'])
        ..style = PaintingStyle.fill;

      final sweepAngle = (item['value'] / 100) * 2 * math.pi;

      // Create path for donut segment
      final path = Path();
      path.arcTo(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        false,
      );
      path.arcTo(
        Rect.fromCircle(center: center, radius: innerRadius),
        startAngle + sweepAngle,
        -sweepAngle,
        false,
      );
      path.close();

      canvas.drawPath(path, paint);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
