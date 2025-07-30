import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/charts_controller.dart';

class BubbleChartWidget extends StatelessWidget {
  const BubbleChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Performance Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => CustomPaint(
                    size: Size.infinite,
                    painter:
                        BubbleChartPainter(controller.bubbleChartData.value),
                  )),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Performance Score', style: TextStyle(fontSize: 10)),
                  Icon(Icons.arrow_upward, size: 16, color: Colors.grey),
                ],
              ),
              Column(
                children: [
                  Text('Experience Level →', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BubbleChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  BubbleChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    // Draw axes
    final axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    // X-axis
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axisPaint,
    );

    // Y-axis
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axisPaint,
    );

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 0.5;

    // Vertical grid lines
    for (int i = 1; i < 5; i++) {
      final x = padding + (chartWidth * i / 5);
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, size.height - padding),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 1; i < 5; i++) {
      final y = padding + (chartHeight * i / 5);
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        gridPaint,
      );
    }

    // Find max values for normalization
    final maxX = data.map((item) => item['x'] as double).reduce(math.max);
    final maxY = data.map((item) => item['y'] as double).reduce(math.max);
    final maxSize = data.map((item) => item['size'] as double).reduce(math.max);

    // Draw bubbles
    for (final item in data) {
      final x = padding + (item['x'] / maxX) * chartWidth;
      final y = size.height - padding - (item['y'] / maxY) * chartHeight;
      final bubbleRadius = (item['size'] / maxSize) * 20 + 5;

      // Draw bubble shadow
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(
        Offset(x + 2, y + 2),
        bubbleRadius,
        shadowPaint,
      );

      // Draw bubble
      final bubblePaint = Paint()
        ..color = Color(item['color']).withOpacity(0.7)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x, y),
        bubbleRadius,
        bubblePaint,
      );

      // Draw bubble border
      final borderPaint = Paint()
        ..color = Color(item['color'])
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
        Offset(x, y),
        bubbleRadius,
        borderPaint,
      );

      // Draw label
      final textPainter = TextPainter(
        text: TextSpan(
          text: item['label'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        x - textPainter.width / 2,
        y - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // Draw axis labels
    final labelStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 12,
    );

    // X-axis values
    for (int i = 0; i <= 5; i++) {
      final value = (maxX * i / 5).toStringAsFixed(0);
      final textPainter = TextPainter(
        text: TextSpan(text: value, style: labelStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final x = padding + (chartWidth * i / 5) - textPainter.width / 2;
      textPainter.paint(canvas, Offset(x, size.height - padding + 10));
    }

    // Y-axis values
    for (int i = 0; i <= 5; i++) {
      final value = (maxY * i / 5).toStringAsFixed(0);
      final textPainter = TextPainter(
        text: TextSpan(text: value, style: labelStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final y = size.height -
          padding -
          (chartHeight * i / 5) -
          textPainter.height / 2;
      textPainter.paint(canvas, Offset(padding - textPainter.width - 10, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
