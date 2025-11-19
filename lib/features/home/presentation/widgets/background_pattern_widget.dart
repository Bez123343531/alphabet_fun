/// 背景图案组件
/// 
/// 绘制应用的背景图案
/// 包含青色背景和重叠圆形纹理，形成类似鳞片或瓷砖的视觉效果
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 背景图案 Widget
/// 
/// 使用 CustomPaint 绘制背景图案
/// 填充整个可用空间
class BackgroundPatternWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  const BackgroundPatternWidget({super.key});

  /// 构建背景图案 UI
  /// 
  /// 使用 CustomPaint 绘制背景
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: CustomPaint Widget，包含绘制的背景图案
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPatternPainter(), // 自定义绘制器
      size: Size.infinite,                 // 填充整个可用空间
    );
  }
}

/// 背景图案绘制器
/// 
/// 负责绘制背景的青色底色和重叠圆形纹理图案
class BackgroundPatternPainter extends CustomPainter {
  /// 绘制背景图案
  /// 
  /// 按照以下顺序绘制：
  /// 1. 青色背景（填充整个画布）
  /// 2. 重叠圆形纹理图案（半透明圆形，形成鳞片效果）
  /// 
  /// [canvas] - 画布对象，用于绘制
  /// [size] - 可用绘制区域的大小
  @override
  void paint(Canvas canvas, Size size) {
    // ==================== 绘制青色背景 ====================
    /// 使用青色填充整个画布作为背景色
    /// 类似鳞片或瓷砖的底色
    final paint = Paint()
      ..color = AppColors.tealBackground  // 青色背景色
      ..style = PaintingStyle.fill;        // 填充模式

    // 绘制整个画布的矩形背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height), // 从 (0,0) 到 (width, height)
      paint,
    );

    // ==================== 绘制图案纹理 ====================
    /// 使用重叠的圆形图案创建纹理效果
    /// 圆形使用半透明青色，形成类似鳞片或瓷砖的视觉效果
    final patternPaint = Paint()
      ..color = AppColors.tealBackground.withOpacity(0.3)  // 半透明青色（30% 透明度）
      ..style = PaintingStyle.fill;

    // 图案参数
    final patternSize = 60.0;  // 图案单元大小（像素）
    final circleRadius = patternSize * 0.3; // 圆形半径（单元大小的 30%）
    final spacing = patternSize * 0.8;     // 圆形间距（单元大小的 80%，形成重叠效果）

    // 使用双重循环绘制网格状的圆形图案
    // 垂直方向
    for (double y = 0; y < size.height; y += spacing) {
      // 水平方向
      for (double x = 0; x < size.width; x += spacing) {
        // 在每个网格点绘制圆形
        canvas.drawCircle(
          Offset(x, y),  // 圆心位置
          circleRadius,  // 圆形半径
          patternPaint,  // 绘制样式
        );
      }
    }
  }

  /// 判断是否需要重新绘制
  /// 
  /// 由于背景图案是静态的，不需要重新绘制
  /// 
  /// [oldDelegate] - 旧的绘制器
  /// 
  /// Returns: false，表示不需要重新绘制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

