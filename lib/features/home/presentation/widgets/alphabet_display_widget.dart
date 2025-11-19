/// 字母表显示组件
/// 
/// 在怪物框架的弧形路径上显示完整的英文字母表（a-z）
/// 字母沿着怪物身体的顶部弧形均匀分布
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 字母表显示 Widget
/// 
/// 使用 CustomPaint 在弧形路径上绘制 26 个英文字母
class AlphabetDisplayWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  const AlphabetDisplayWidget({super.key});

  /// 完整的英文字母表（小写）
  static const String _alphabet = 'abcdefghijklmnopqrstuvwxyz';

  /// 构建字母表显示 UI
  /// 
  /// 使用 CustomPaint 绘制字母
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: CustomPaint Widget，包含绘制的字母
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AlphabetPainter(), // 自定义绘制器，负责绘制字母
      size: Size.infinite,        // 填充整个可用空间
    );
  }
}

/// 字母表绘制器
/// 
/// 负责在画布上沿着弧形路径绘制 26 个英文字母
/// 使用二次贝塞尔曲线计算每个字母的位置
class AlphabetPainter extends CustomPainter {
  /// 完整的英文字母表（小写）
  static const String _alphabet = 'abcdefghijklmnopqrstuvwxyz';

  /// 绘制字母表
  /// 
  /// 沿着怪物身体的顶部弧形路径绘制每个字母
  /// 使用二次贝塞尔曲线公式计算每个字母的精确位置
  /// 
  /// [canvas] - 画布对象，用于绘制
  /// [size] - 可用绘制区域的大小
  @override
  void paint(Canvas canvas, Size size) {
    // 创建文本绘制器，用于绘制每个字母
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr, // 从左到右的文本方向
    );

    // 定义字母的文本样式
    final textStyle = TextStyle(
      color: AppColors.white,              // 白色文字（在橙色背景上显示）
      fontSize: size.width * 0.025,       // 字体大小为屏幕宽度的 2.5%
      fontWeight: FontWeight.w500,         // 中等粗细
      fontFamily: 'Roboto',                // 使用 Roboto 字体
    );

    // ==================== 计算弧形路径 ====================
    /// 沿着怪物身体的顶部弧形路径绘制字母
    /// 使用二次贝塞尔曲线模拟怪物身体的弧形
    /// 
    /// 贝塞尔曲线参数：
    /// - P₀: 起点 (0, topY) - 左上角
    /// - P₁: 控制点 (width/2, controlY) - 顶部中心（向上凸起）
    /// - P₂: 终点 (width, topY) - 右上角
    final topY = size.height * 0.15;      // 弧形顶部 Y 坐标（距离顶部 15%）
    final controlY = size.height * 0.05;  // 控制点 Y 坐标（距离顶部 5%，形成向上凸起的弧形）
    
    // ==================== 绘制每个字母 ====================
    /// 遍历字母表中的每个字母，计算其在弧形上的位置并绘制
    for (int i = 0; i < _alphabet.length; i++) {
      // 计算参数 t，范围从 0.0 到 1.0
      // 当 i=0 时，t=0（起点）；当 i=25 时，t=1（终点）
      final t = i / (_alphabet.length - 1);
      
      // ==================== 使用二次贝塞尔曲线公式计算位置 ====================
      /// 二次贝塞尔曲线公式：P(t) = (1-t)²P₀ + 2(1-t)tP₁ + t²P₂
      /// 
      /// 对于 X 坐标：线性分布（从 0 到 width）
      final x = size.width * t;
      
      /// 对于 Y 坐标：使用贝塞尔曲线公式计算弧形上的点
      /// (1-t)² * topY 是起点的影响
      /// 2(1-t)t * controlY 是控制点的影响（形成弧形）
      /// t² * topY 是终点的影响
      final y = (1 - t) * (1 - t) * topY +      // 起点项
                2 * (1 - t) * t * controlY +     // 控制点项（形成弧形）
                t * t * topY;                    // 终点项

      // ==================== 绘制字母 ====================
      /// 设置要绘制的文本内容
      textPainter.text = TextSpan(
        text: _alphabet[i],  // 当前字母
        style: textStyle,    // 应用文本样式
      );
      
      /// 布局文本，计算文本的实际尺寸
      textPainter.layout();

      /// 在计算好的位置绘制字母
      /// 使用 Offset 将字母中心对齐到计算出的坐标
      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,   // X 坐标：减去文本宽度的一半，实现居中对齐
          y - textPainter.height / 2,  // Y 坐标：减去文本高度的一半，实现居中对齐
        ),
      );
    }
  }

  /// 判断是否需要重新绘制
  /// 
  /// 由于字母表是静态的，不需要重新绘制
  /// 
  /// [oldDelegate] - 旧的绘制器
  /// 
  /// Returns: false，表示不需要重新绘制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

