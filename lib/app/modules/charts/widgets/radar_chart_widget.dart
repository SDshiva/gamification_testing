import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/charts_controller.dart';

class RadarChartWidget extends StatelessWidget {
  const RadarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Skill Assessment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => CustomPaint(
                  size: const Size(300, 300),
                  painter: RadarChartPainter(controller.radarChartData.value),
                )),
          ),
          const SizedBox(height: 20),
          Obx(() => Wrap(
                spacing: 16,
                runSpacing: 8,
                children: controller.radarChartData.value['labels']
                    .asMap()
                    .entries
                    .map<Widget>(
                      (entry) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            entry.value,
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

class RadarChartPainter extends CustomPainter {
  final Map<String, dynamic> data;

  RadarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty || data['labels'] == null || data['values'] == null)
      return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 30;
    final labels = data['labels'] as List<String>;
    final values = data['values'] as List<double>;

    // Draw grid circles
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(center, radius * i / 5, gridPaint);
    }

    // Draw axes
    final axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;

    for (int i = 0; i < labels.length; i++) {
      final angle = (i * 2 * math.pi / labels.length) - math.pi / 2;
      final endPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, endPoint, axisPaint);

      // Draw labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final labelOffset = Offset(
        center.dx + (radius + 15) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius + 15) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, labelOffset);
    }

    // Draw data polygon
    final dataPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    for (int i = 0; i < values.length; i++) {
      final angle = (i * 2 * math.pi / labels.length) - math.pi / 2;
      final value = values[i] / 100; // Normalize to 0-1
      final point = Offset(
        center.dx + radius * value * math.cos(angle),
        center.dy + radius * value * math.sin(angle),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }

      // Draw data points
      canvas.drawCircle(point, 4, Paint()..color = Colors.blue);
    }

    path.close();
    canvas.drawPath(path, dataPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
