/// 所有图片都包含错误处理，确保加载失败时显示友好的错误提示
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_colors.dart';

/// 首页组件
/// 
/// 简化版本，使用现有图片替代代码生成图形：
/// - 背景：使用 shouye.png
/// - 左上角：zhangyu.png（位于所有元素最上层）
/// - 右上角：hong.png
/// - 右下角：more_card.png（位于轮盘菜单上层）
/// - 导航：轮盘菜单
/// 
/// 使用 Stack 布局实现元素的层叠效果
class HomePage extends StatelessWidget {
  static const double designWidth = 2560;
  static const double designHeight = 1440;

  /// 构造函数
  const HomePage({
    super.key,
    this.showDebugOverlay = false,
  });

  /// 是否显示调试用坐标网格
  final bool showDebugOverlay;

  /// 构建页面 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: AppColors.tealBackground,
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: designWidth,
                height: designHeight,
                child: Stack(
                  children: [
                    // ==================== 背景层 ====================
                    /// 背景图片：shouye.png
                    Positioned.fill(
                      child: Image(
                        image: AssetImage('assets/images/shouye.png'),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.tealBackground,
                            child: const Center(
                              child: Text(
                                'Loading...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

          // ==================== 右上角区域 ====================
          /// hong.png 位于右上角
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage('assets/images/hong.png'),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightBlue,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // ==================== 信息图标 ====================
          /// 左上角信息图标
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                // TODO: 处理信息图标点击事件
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          
          // ==================== 左上角区域 ====================
          /// zhangyu.png 位于所有图片元素的最上层
          Positioned(
            left: 190,
            top: 390,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage('assets/images/zhangyu.png'),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightBlue,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // ==================== 自定义 more_card.png ====================
          /// 将 more_card.png 指定坐标点对齐在背景上方
          Positioned(
            left: 1945, // 2421 - 1009
            top: 1001, // 1399 - 1009
            child: GestureDetector(
              onTap: () {
                // TODO: 处理 more_card.png 点击事件
              },
              child: Container(
                width: 580,
                height: 580,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage('assets/images/more_card.png'),
                    fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.lightBlue,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.white,
                            size: 35,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
                    // ==================== 调试坐标系 ====================
                    if (showDebugOverlay)
                      const Positioned.fill(
                        child: CoordinateOverlay(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 用于在 UI 上显示坐标网格，便于定位元素
class CoordinateOverlay extends StatelessWidget {
  const CoordinateOverlay({
    super.key,
    this.interval = 100,
  });

  final double interval;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: _CoordinatePainter(interval: interval),
          );
        },
      ),
    );
  }
}

class _CoordinatePainter extends CustomPainter {
  _CoordinatePainter({required this.interval});

  final double interval;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 1.5;

    for (double x = 0; x <= size.width; x += interval) {
      final paint = x == 0 ? axisPaint : gridPaint;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      _drawLabel(canvas, Offset(x + 4, 4), '${x.toInt()}');
    }

    for (double y = 0; y <= size.height; y += interval) {
      final paint = y == 0 ? axisPaint : gridPaint;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      _drawLabel(canvas, Offset(4, y + 4), '${y.toInt()}');
    }
  }

  void _drawLabel(Canvas canvas, Offset offset, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}