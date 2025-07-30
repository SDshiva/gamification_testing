import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/charts_controller.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Monthly Sales',
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
                  painter: BarChartPainter(controller.barChartData.value),
                )),
          ),
          const SizedBox(height: 20),
          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.barChartData.value
                      .map((item) => Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              item['label'] as String,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            ),
                          ))
                      .toList(),
                ),
              )),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final barWidth = size.width / data.length * 0.8;
    final spacing = size.width / data.length * 0.2;

    for (int i = 0; i < data.length; i++) {
      final paint = Paint()
        ..color = Color(data[i]['color'] as int)
        ..style = PaintingStyle.fill;

      final barHeight = ((data[i]['value'] as double) / 100) * size.height;
      final x = i * (barWidth + spacing) + spacing / 2;
      final y = size.height - barHeight;

      final rect = Rect.fromLTWH(x, y, barWidth, barHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        paint,
      );

      // Draw value on top of bar
      final textPainter = TextPainter(
        text: TextSpan(
          text: (data[i]['value'] as double).toStringAsFixed(0),
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + barWidth / 2 - textPainter.width / 2, y - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
