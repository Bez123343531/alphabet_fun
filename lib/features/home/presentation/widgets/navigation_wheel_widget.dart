/// 导航轮组件
/// 
/// 位于页面右下角的圆形导航控件
/// 用于切换不同等级和功能选项
/// 包含：ALL、1、2、3、MORE 等分段
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 导航轮 Widget
/// 
/// 提供圆形导航界面，用户可以通过点击不同分段切换功能
/// 中心显示返回箭头图标
class NavigationWheelWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  /// [onLevelSelected] - 可选，等级选择回调函数
  const NavigationWheelWidget({
    super.key,
    this.onLevelSelected,
  });

  /// 等级选择回调函数
  /// 当用户选择某个等级时调用，参数为选中的等级编号
  final ValueChanged<int>? onLevelSelected;

  /// 构建导航轮 UI
  /// 
  /// 使用 CustomPaint 绘制圆形导航轮
  /// 中心显示返回箭头图标
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: Positioned Widget，位于右下角
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,   // 距离右侧 20 像素
      bottom: 20,  // 距离底部 20 像素
      child: GestureDetector(
        onTap: () {
          // TODO: 处理点击事件
          // 可以显示导航菜单或执行其他操作
        },
        child: CustomPaint(
          size: const Size(120, 120),        // 固定尺寸 120x120
          painter: NavigationWheelPainter(), // 自定义绘制器
          child: const Center(
            child: Icon(
              Icons.arrow_back,              // 返回箭头图标
              color: AppColors.white,         // 白色图标
              size: 30,                      // 图标大小 30
            ),
          ),
        ),
      ),
    );
  }
}

/// 导航轮绘制器
/// 
/// 负责绘制圆形导航轮的所有细节
/// 包括：橙色背景、分段分割线、分段文字标签
class NavigationWheelPainter extends CustomPainter {
  /// 绘制导航轮
  /// 
  /// 按照以下顺序绘制：
  /// 1. 橙色圆形背景
  /// 2. 分段分割线（浅橙色）
  /// 3. 分段文字标签（ALL、1、2、3、MORE）
  /// 
  /// [canvas] - 画布对象，用于绘制
  /// [size] - 可用绘制区域的大小
  @override
  void paint(Canvas canvas, Size size) {
    // ==================== 计算中心点和半径 ====================
    final center = Offset(size.width / 2, size.height / 2); // 圆心
    final radius = size.width / 2;                          // 半径（圆形）

    // ==================== 绘制橙色圆形背景 ====================
    /// 导航轮的主体背景，使用橙色填充
    final backgroundPaint = Paint()
      ..color = AppColors.orangeMonster  // 橙色
      ..style = PaintingStyle.fill;       // 填充模式

    canvas.drawCircle(center, radius, backgroundPaint);

    // ==================== 绘制分段分割线 ====================
    /// 使用浅橙色线条将圆形分成多个分段
    final segmentPaint = Paint()
      ..color = AppColors.lightOrange  // 浅橙色
      ..style = PaintingStyle.stroke    // 描边模式
      ..strokeWidth = 2;                // 线条宽度 2

    // ==================== 准备文本绘制器 ====================
    /// 用于绘制分段文字标签
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr, // 从左到右的文本方向
    );

    // 定义文字样式
    final textStyle = const TextStyle(
      color: AppColors.white,      // 白色文字
      fontSize: 14,                // 字体大小 14
      fontWeight: FontWeight.bold, // 粗体
    );

    // ==================== 定义分段标签 ====================
    /// 导航轮的五个分段：ALL、1、2、3、MORE
    final segments = ['ALL', '1', '2', '3', 'MORE'];
    final angleStep = (2 * 3.14159) / segments.length; // 每个分段的角度（360度 / 5 = 72度）

    // ==================== 绘制每个分段 ====================
    /// 遍历每个分段，绘制分割线和文字标签
    for (int i = 0; i < segments.length; i++) {
      // 计算当前分段的角度
      // 从 -90 度（顶部）开始，顺时针分布
      final angle = (i * angleStep) - (3.14159 / 2); // -90 度 + i * 72度
      final segmentAngle = angle + angleStep / 2;     // 分段中心角度（用于放置文字）

      // ==================== 绘制分割线 ====================
      /// 从圆内 70% 位置到边缘的径向线条
      final lineStart = Offset(
        center.dx + (radius * 0.7) * math.cos(angle), // 起点：半径的 70% 位置
        center.dy + (radius * 0.7) * math.sin(angle),
      );
      final lineEnd = Offset(
        center.dx + radius * math.cos(angle),         // 终点：边缘
        center.dy + radius * math.sin(angle),
      );

      canvas.drawLine(lineStart, lineEnd, segmentPaint);

      // ==================== 绘制文字标签 ====================
      /// 在分段中心位置绘制文字标签
      final textX = center.dx + (radius * 0.5) * math.cos(segmentAngle); // 文字 X 坐标（半径的 50% 位置）
      final textY = center.dy + (radius * 0.5) * math.sin(segmentAngle);   // 文字 Y 坐标

      // 设置要绘制的文本
      textPainter.text = TextSpan(
        text: segments[i],  // 当前分段的文字
        style: textStyle,   // 应用文本样式
      );
      textPainter.layout(); // 布局文本，计算实际尺寸

      // 绘制文字（居中对齐）
      textPainter.paint(
        canvas,
        Offset(
          textX - textPainter.width / 2,   // X 坐标：减去文本宽度的一半，实现居中对齐
          textY - textPainter.height / 2,  // Y 坐标：减去文本高度的一半，实现居中对齐
        ),
      );
    }
  }

  /// 判断是否需要重新绘制
  /// 
  /// 由于导航轮是静态的，不需要重新绘制
  /// 
  /// [oldDelegate] - 旧的绘制器
  /// 
  /// Returns: false，表示不需要重新绘制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

