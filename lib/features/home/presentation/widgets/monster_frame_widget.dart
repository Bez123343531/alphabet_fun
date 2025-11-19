/// 怪物框架组件
/// 
/// 绘制一个橙色三眼怪物作为页面的框架
/// 怪物包含：三个眼睛、两个角、紫色领结
/// 怪物的身体形成弧形窗口，用于展示内容
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 怪物框架 Widget
/// 
/// 使用 CustomPaint 绘制怪物形状，并将子组件显示在怪物形成的窗口内
/// 
/// [child] - 显示在怪物框架内的子组件（通常是字母表和单词卡片）
class MonsterFrameWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  /// [child] - 必需，显示在框架内的子组件
  const MonsterFrameWidget({
    super.key,
    required this.child,
  });

  /// 显示在怪物框架内的子组件
  final Widget child;

  /// 构建怪物框架 UI
  /// 
  /// 使用 CustomPaint 绘制怪物形状，并将子组件叠加在上方
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: CustomPaint Widget，包含绘制的怪物和子组件
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MonsterFramePainter(), // 自定义绘制器，负责绘制怪物
      child: child,                    // 子组件显示在怪物框架内
    );
  }
}

/// 怪物框架绘制器
/// 
/// 负责在画布上绘制橙色三眼怪物的所有细节
/// 包括：身体框架、三个眼睛、两个角、紫色领结
class MonsterFramePainter extends CustomPainter {
  /// 绘制怪物框架
  /// 
  /// 按照以下顺序绘制：
  /// 1. 怪物身体（弧形框架）
  /// 2. 三个眼睛（白色眼白 + 棕色瞳孔）
  /// 3. 两个角（浅橙色）
  /// 4. 紫色领结（底部中心）
  /// 
  /// [canvas] - 画布对象，用于绘制
  /// [size] - 可用绘制区域的大小
  @override
  void paint(Canvas canvas, Size size) {
    // ==================== 绘制怪物身体 ====================
    /// 使用橙色填充绘制怪物身体
    /// 身体形成弧形窗口，用于展示内容
    final paint = Paint()
      ..color = AppColors.orangeMonster  // 橙色
      ..style = PaintingStyle.fill;       // 填充模式

    final path = Path();

    // 绘制怪物身体（弧形框架，形成窗口效果）
    // 顶部弧形（从左上到右上）
    // 使用二次贝塞尔曲线创建平滑的弧形
    path.moveTo(0, size.height * 0.15);  // 起点：左上角
    path.quadraticBezierTo(
      size.width * 0.5,      // 控制点：顶部中心（向上凸起）
      size.height * 0.05,    // 控制点 Y 坐标，形成弧形
      size.width,           // 终点：右上角
      size.height * 0.15,    // 终点 Y 坐标
    );

    // 右侧向下（形成右侧边框）
    path.lineTo(size.width, size.height * 0.85);

    // 底部弧形（从右下到左下，形成窗口底部）
    // 同样使用二次贝塞尔曲线，但向下凸起
    path.quadraticBezierTo(
      size.width * 0.5,      // 控制点：底部中心（向下凸起）
      size.height * 0.95,    // 控制点 Y 坐标
      0,                     // 终点：左下角
      size.height * 0.85,    // 终点 Y 坐标
    );

    // 左侧向上（形成左侧边框）
    path.lineTo(0, size.height * 0.15);
    path.close(); // 闭合路径

    // 绘制怪物身体路径
    canvas.drawPath(path, paint);

    // ==================== 绘制三个眼睛 ====================
    /// 眼睛由白色眼白和棕色瞳孔组成
    /// 三个眼睛水平排列在怪物头部
    final eyePaint = Paint()
      ..color = AppColors.white      // 白色眼白
      ..style = PaintingStyle.fill;

    final pupilPaint = Paint()
      ..color = AppColors.brownText  // 棕色瞳孔
      ..style = PaintingStyle.fill;

    // 计算眼睛的尺寸和位置
    final eyeRadius = size.width * 0.03;      // 眼白半径（屏幕宽度的 3%）
    final pupilRadius = size.width * 0.015;    // 瞳孔半径（眼白的一半）
    final eyeY = size.height * 0.12;          // 眼睛的 Y 坐标（距离顶部 12%）

    // 左眼（屏幕宽度的 35% 位置）
    canvas.drawCircle(
      Offset(size.width * 0.35, eyeY),
      eyeRadius,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.35, eyeY),
      pupilRadius,
      pupilPaint,
    );

    // 中眼（屏幕中心）
    canvas.drawCircle(
      Offset(size.width * 0.5, eyeY),
      eyeRadius,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, eyeY),
      pupilRadius,
      pupilPaint,
    );

    // 右眼（屏幕宽度的 65% 位置）
    canvas.drawCircle(
      Offset(size.width * 0.65, eyeY),
      eyeRadius,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, eyeY),
      pupilRadius,
      pupilPaint,
    );

    // ==================== 绘制两个角 ====================
    /// 使用浅橙色绘制两个三角形角
    /// 位于怪物头部两侧
    final hornPaint = Paint()
      ..color = AppColors.lightOrange  // 浅橙色
      ..style = PaintingStyle.fill;

    // 左角（使用三角形路径）
    final hornPath1 = Path();
    hornPath1.moveTo(size.width * 0.25, size.height * 0.08);  // 起点
    hornPath1.lineTo(size.width * 0.22, size.height * 0.02);  // 顶点（最上方）
    hornPath1.lineTo(size.width * 0.28, size.height * 0.05); // 右侧点
    hornPath1.close(); // 闭合形成三角形
    canvas.drawPath(hornPath1, hornPaint);

    // 右角（对称位置）
    final hornPath2 = Path();
    hornPath2.moveTo(size.width * 0.75, size.height * 0.08);  // 起点
    hornPath2.lineTo(size.width * 0.78, size.height * 0.02);  // 顶点（最上方）
    hornPath2.lineTo(size.width * 0.72, size.height * 0.05);  // 左侧点
    hornPath2.close(); // 闭合形成三角形
    canvas.drawPath(hornPath2, hornPaint);

    // ==================== 绘制紫色领结 ====================
    /// 领结由三个部分组成：左侧椭圆、右侧椭圆、中心矩形
    /// 位于怪物底部中心位置
    final bowTiePaint = Paint()
      ..color = AppColors.purpleBowTie  // 紫色
      ..style = PaintingStyle.fill;

    final bowTiePath = Path();
    final bowTieY = size.height * 0.88;        // 领结 Y 坐标（距离顶部 88%）
    final bowTieWidth = size.width * 0.08;     // 领结宽度
    final bowTieHeight = size.height * 0.04;  // 领结高度

    // 领结左侧（椭圆）
    bowTiePath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5 - bowTieWidth * 0.3, bowTieY),
      width: bowTieWidth,
      height: bowTieHeight,
    ));

    // 领结右侧（椭圆）
    bowTiePath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5 + bowTieWidth * 0.3, bowTieY),
      width: bowTieWidth,
      height: bowTieHeight,
    ));

    // 领结中心（矩形，连接左右两侧）
    bowTiePath.addRect(Rect.fromCenter(
      center: Offset(size.width * 0.5, bowTieY),
      width: bowTieWidth * 0.3,   // 中心宽度为总宽度的 30%
      height: bowTieHeight * 0.6, // 中心高度为总高度的 60%
    ));

    // 绘制完整的领结
    canvas.drawPath(bowTiePath, bowTiePaint);
  }

  /// 判断是否需要重新绘制
  /// 
  /// 由于怪物框架是静态的，不需要重新绘制
  /// 
  /// [oldDelegate] - 旧的绘制器
  /// 
  /// Returns: false，表示不需要重新绘制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

