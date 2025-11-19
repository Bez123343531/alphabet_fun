/// 单词卡片组件
/// 
/// 显示当前学习的单词，包含：
/// - 单词插图（蓝色小怪物、篮子、鸡舍、鸡）
/// - 单词文本（大号棕色文字）
/// - 等级标识（粉色标签）
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 单词卡片 Widget
/// 
/// 展示教育游戏中的单词学习卡片
/// 包含插图、单词文本和等级信息
class WordCardWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  /// [word] - 必需，要显示的单词
  /// [level] - 必需，当前等级
  const WordCardWidget({
    super.key,
    required this.word,
    required this.level,
  });

  /// 要显示的单词文本
  final String word;
  
  /// 当前等级（1, 2, 3 等）
  final int level;

  /// 构建单词卡片 UI
  /// 
  /// 创建白色卡片容器，包含：
  /// 1. 顶部：单词插图
  /// 2. 中间：单词文本
  /// 3. 底部右侧：等级标识
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: 构建完成的单词卡片 Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      // 外边距：水平 40 像素，垂直 20 像素
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,                    // 白色背景
        borderRadius: BorderRadius.circular(16),     // 圆角半径 16
        boxShadow: [
          // 阴影效果，增加卡片的立体感
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // 黑色，20% 透明度
            blurRadius: 10,                        // 模糊半径 10
            offset: const Offset(0, 4),            // 向下偏移 4 像素
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 最小高度，根据内容自适应
        children: [
          // ==================== 插图区域 ====================
          /// 单词插图，展示与单词相关的场景
          /// 例如 "basket" 单词显示：蓝色小怪物拿着篮子，旁边有鸡舍和鸡
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // 内边距 16 像素
              child: _buildIllustration(context),   // 构建插图
            ),
          ),
          
          // ==================== 单词显示 ====================
          /// 显示单词文本，使用大号粗体棕色文字
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              word,
              style: TextStyle(
                fontSize: 48,                      // 字体大小 48
                fontWeight: FontWeight.bold,        // 粗体
                color: AppColors.brownText,        // 棕色文字
                letterSpacing: 2,                  // 字母间距 2
              ),
            ),
          ),
          
          // ==================== 等级标识 ====================
          /// 右下角显示当前等级标签
          /// 使用粉色背景，白色文字
          Align(
            alignment: Alignment.bottomRight,      // 右下角对齐
            child: Container(
              margin: const EdgeInsets.all(12.0),   // 外边距 12 像素
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: AppColors.pinkLevel,        // 粉色背景
                borderRadius: BorderRadius.circular(8), // 圆角半径 8
              ),
              child: Text(
                'Level $level',                     // 显示 "Level 3" 等
                style: const TextStyle(
                  color: AppColors.white,          // 白色文字
                  fontSize: 14,                    // 字体大小 14
                  fontWeight: FontWeight.bold,     // 粗体
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建插图 Widget
  /// 
  /// 使用 CustomPaint 绘制单词相关的插图场景
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: CustomPaint Widget，包含绘制的插图
  Widget _buildIllustration(BuildContext context) {
    return CustomPaint(
      painter: WordIllustrationPainter(), // 自定义绘制器
      size: Size.infinite,                // 填充整个可用空间
    );
  }
}

/// 单词插图绘制器
/// 
/// 负责绘制与单词相关的插图场景
/// 例如 "basket" 单词的插图包含：
/// - 蓝色小怪物（拿着篮子）
/// - 棕色篮子（带纹理）
/// - 红色鸡舍（带粉色屋顶和棕色门）
/// - 白色鸡（从鸡舍探出头，带红色鸡冠）
class WordIllustrationPainter extends CustomPainter {
  /// 绘制单词插图
  /// 
  /// 按照以下顺序绘制：
  /// 1. 蓝色小怪物（圆形身体、眼睛、角）
  /// 2. 棕色篮子（带横向纹理线条）
  /// 3. 红色鸡舍（主体、粉色屋顶、棕色门）
  /// 4. 白色鸡（头部、红色鸡冠）
  /// 
  /// [canvas] - 画布对象，用于绘制
  /// [size] - 可用绘制区域的大小
  @override
  void paint(Canvas canvas, Size size) {
    // ==================== 绘制蓝色小怪物 ====================
    /// 小怪物位于左侧，由圆形身体、两个眼睛、两个角组成
    final monsterPaint = Paint()
      ..color = AppColors.blueMonster  // 蓝色
      ..style = PaintingStyle.fill;

    // 计算怪物的位置和大小
    final monsterX = size.width * 0.25;        // X 坐标：屏幕宽度的 25%
    final monsterY = size.height * 0.5;        // Y 坐标：屏幕高度的 50%（垂直居中）
    final monsterRadius = size.width * 0.12;  // 半径：屏幕宽度的 12%

    // 绘制怪物身体（圆形）
    canvas.drawCircle(
      Offset(monsterX, monsterY),
      monsterRadius,
      monsterPaint,
    );

    // ==================== 绘制怪物的眼睛 ====================
    /// 两个眼睛，每个由白色眼白和黑色瞳孔组成
    final eyePaint = Paint()
      ..color = AppColors.white  // 白色眼白
      ..style = PaintingStyle.fill;

    final pupilPaint = Paint()
      ..color = AppColors.black  // 黑色瞳孔
      ..style = PaintingStyle.fill;

    // 左眼
    canvas.drawCircle(
      Offset(monsterX - monsterRadius * 0.3, monsterY - monsterRadius * 0.2),
      monsterRadius * 0.15,  // 眼白半径
      eyePaint,
    );
    canvas.drawCircle(
      Offset(monsterX - monsterRadius * 0.3, monsterY - monsterRadius * 0.2),
      monsterRadius * 0.08,  // 瞳孔半径（眼白的一半）
      pupilPaint,
    );

    // 右眼
    canvas.drawCircle(
      Offset(monsterX + monsterRadius * 0.3, monsterY - monsterRadius * 0.2),
      monsterRadius * 0.15,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(monsterX + monsterRadius * 0.3, monsterY - monsterRadius * 0.2),
      monsterRadius * 0.08,
      pupilPaint,
    );

    // ==================== 绘制怪物的角 ====================
    /// 两个浅蓝色三角形角，位于怪物头部两侧
    final hornPaint = Paint()
      ..color = AppColors.lightBlue  // 浅蓝色
      ..style = PaintingStyle.fill;

    // 左角（三角形路径）
    final hornPath1 = Path();
    hornPath1.moveTo(monsterX - monsterRadius * 0.3, monsterY - monsterRadius * 0.8);
    hornPath1.lineTo(monsterX - monsterRadius * 0.5, monsterY - monsterRadius * 1.2);
    hornPath1.lineTo(monsterX - monsterRadius * 0.1, monsterY - monsterRadius * 1.0);
    hornPath1.close(); // 闭合形成三角形
    canvas.drawPath(hornPath1, hornPaint);

    // 右角（对称位置）
    final hornPath2 = Path();
    hornPath2.moveTo(monsterX + monsterRadius * 0.3, monsterY - monsterRadius * 0.8);
    hornPath2.lineTo(monsterX + monsterRadius * 0.5, monsterY - monsterRadius * 1.2);
    hornPath2.lineTo(monsterX + monsterRadius * 0.1, monsterY - monsterRadius * 1.0);
    hornPath2.close();
    canvas.drawPath(hornPath2, hornPaint);

    // ==================== 绘制篮子 ====================
    /// 棕色篮子，位于怪物下方
    /// 使用路径绘制篮子形状，并添加横向纹理线条
    final basketPaint = Paint()
      ..color = AppColors.brownText  // 棕色
      ..style = PaintingStyle.fill;

    final basketPath = Path();
    final basketX = monsterX;                              // 篮子 X 坐标（与怪物对齐）
    final basketY = monsterY + monsterRadius * 0.6;        // 篮子 Y 坐标（怪物下方）
    final basketWidth = monsterRadius * 0.8;                // 篮子宽度
    final basketHeight = monsterRadius * 0.6;              // 篮子高度

    // 绘制篮子路径（使用二次贝塞尔曲线创建篮子的弧形顶部）
    basketPath.moveTo(basketX - basketWidth / 2, basketY); // 起点：左下角
    basketPath.lineTo(basketX - basketWidth / 2, basketY - basketHeight); // 左侧边
    // 顶部左侧弧形
    basketPath.quadraticBezierTo(
      basketX - basketWidth / 2,
      basketY - basketHeight - basketHeight * 0.2,  // 控制点（向上凸起）
      basketX,
      basketY - basketHeight - basketHeight * 0.2,  // 顶部中心
    );
    // 顶部右侧弧形
    basketPath.quadraticBezierTo(
      basketX + basketWidth / 2,
      basketY - basketHeight - basketHeight * 0.2,  // 控制点
      basketX + basketWidth / 2,
      basketY - basketHeight,                        // 右侧边顶部
    );
    basketPath.lineTo(basketX + basketWidth / 2, basketY); // 右侧边
    basketPath.close(); // 闭合路径

    // 绘制篮子主体
    canvas.drawPath(basketPath, basketPaint);

    // ==================== 绘制篮子纹理 ====================
    /// 添加横向线条，模拟篮子的编织纹理
    final basketLinePaint = Paint()
      ..color = AppColors.brownText.withOpacity(0.5)  // 半透明棕色
      ..style = PaintingStyle.stroke                   // 描边模式
      ..strokeWidth = 2;                               // 线条宽度 2

    // 绘制 3 条横向纹理线
    for (int i = 1; i < 4; i++) {
      final y = basketY - basketHeight + (basketHeight / 4) * i;
      canvas.drawLine(
        Offset(basketX - basketWidth / 2, y),  // 起点
        Offset(basketX + basketWidth / 2, y),   // 终点
        basketLinePaint,
      );
    }

    // ==================== 绘制鸡舍 ====================
    /// 红色鸡舍，位于右侧
    /// 包含：主体、粉色屋顶、棕色门、从门探出头的鸡
    final coopPaint = Paint()
      ..color = AppColors.redCoop  // 红色
      ..style = PaintingStyle.fill;

    // 计算鸡舍的位置和大小
    final coopX = size.width * 0.75;        // X 坐标：屏幕宽度的 75%
    final coopY = size.height * 0.5;       // Y 坐标：屏幕高度的 50%（垂直居中）
    final coopWidth = size.width * 0.25;    // 宽度：屏幕宽度的 25%
    final coopHeight = size.height * 0.3;    // 高度：屏幕高度的 30%

    // 鸡舍主体（矩形）
    final coopPath = Path();
    coopPath.moveTo(coopX - coopWidth / 2, coopY);              // 左下角
    coopPath.lineTo(coopX - coopWidth / 2, coopY - coopHeight); // 左上角
    coopPath.lineTo(coopX + coopWidth / 2, coopY - coopHeight); // 右上角
    coopPath.lineTo(coopX + coopWidth / 2, coopY);              // 右下角
    coopPath.close();

    canvas.drawPath(coopPath, coopPaint);

    // ==================== 鸡舍屋顶 ====================
    /// 粉色三角形屋顶，位于鸡舍主体上方
    final roofPaint = Paint()
      ..color = Colors.pink.shade200  // 浅粉色
      ..style = PaintingStyle.fill;

    final roofPath = Path();
    roofPath.moveTo(coopX - coopWidth / 2, coopY - coopHeight);              // 左下角
    roofPath.lineTo(coopX, coopY - coopHeight - coopHeight * 0.3);          // 顶点（向上凸起）
    roofPath.lineTo(coopX + coopWidth / 2, coopY - coopHeight);             // 右下角
    roofPath.close(); // 闭合形成三角形

    canvas.drawPath(roofPath, roofPaint);

    // ==================== 绘制鸡舍入口（小门） ====================
    /// 棕色矩形门，位于鸡舍主体中心偏上
    final doorPaint = Paint()
      ..color = AppColors.brownText  // 棕色
      ..style = PaintingStyle.fill;

    final doorWidth = coopWidth * 0.3;   // 门宽度为鸡舍宽度的 30%
    final doorHeight = coopHeight * 0.4; // 门高度为鸡舍高度的 40%
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(coopX, coopY - coopHeight * 0.2), // 门中心位置
        width: doorWidth,
        height: doorHeight,
      ),
      doorPaint,
    );

    // ==================== 绘制鸡（从鸡舍里探出头） ====================
    /// 白色圆形鸡头，从鸡舍顶部探出
    /// 带红色鸡冠
    final chickenPaint = Paint()
      ..color = AppColors.white  // 白色
      ..style = PaintingStyle.fill;

    final chickenHeadX = coopX;                              // 鸡头 X 坐标（与鸡舍对齐）
    final chickenHeadY = coopY - coopHeight * 0.5;          // 鸡头 Y 坐标（鸡舍顶部）
    final chickenHeadRadius = coopWidth * 0.08;              // 鸡头半径

    // 绘制鸡头（圆形）
    canvas.drawCircle(
      Offset(chickenHeadX, chickenHeadY),
      chickenHeadRadius,
      chickenPaint,
    );

    // ==================== 鸡冠 ====================
    /// 红色三角形鸡冠，位于鸡头顶部
    final combPaint = Paint()
      ..color = AppColors.redCoop  // 红色
      ..style = PaintingStyle.fill;

    final combPath = Path();
    combPath.moveTo(chickenHeadX, chickenHeadY - chickenHeadRadius);                    // 起点：鸡头顶部
    combPath.lineTo(chickenHeadX - chickenHeadRadius * 0.3, chickenHeadY - chickenHeadRadius * 1.3); // 左侧点
    combPath.lineTo(chickenHeadX, chickenHeadY - chickenHeadRadius * 1.1);             // 中心点（最高点）
    combPath.lineTo(chickenHeadX + chickenHeadRadius * 0.3, chickenHeadY - chickenHeadRadius * 1.3); // 右侧点
    combPath.close(); // 闭合形成三角形鸡冠

    canvas.drawPath(combPath, combPaint);
  }

  /// 判断是否需要重新绘制
  /// 
  /// 由于插图是静态的，不需要重新绘制
  /// 
  /// [oldDelegate] - 旧的绘制器
  /// 
  /// Returns: false，表示不需要重新绘制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
