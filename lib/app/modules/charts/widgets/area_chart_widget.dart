import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/charts_controller.dart';

class AreaChartWidget extends StatelessWidget {
  const AreaChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      builder: (controller) => Column(
        children: [
          const Text(
            'Growth Over Time',
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
                  painter: AreaChartPainter(controller.areaChartData.value),
                )),
          ),
          const SizedBox(height: 20),
          const Text(
            'Time Periods →',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class AreaChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  AreaChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = Colors.green.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final strokePath = Path();

    // Start from bottom left
    path.moveTo(0, size.height);
    strokePath.moveTo(0, size.height - (data.first['y'] / 100) * size.height);

    // Draw the area
    for (int i = 0; i < data.length; i++) {
      final x = (data[i]['x'] / (data.length - 1)) * size.width;
      final y = size.height - (data[i]['y'] / 100) * size.height;

      if (i == 0) {
        path.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        strokePath.lineTo(x, y);
      }
    }

    // Close the area to bottom right
    path.lineTo(size.width, size.height);
    path.close();

    // Draw filled area
    canvas.drawPath(path, paint);

    // Draw stroke line
    canvas.drawPath(strokePath, strokePaint);

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = (i / 4) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
