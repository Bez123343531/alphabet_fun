/// 背景图案组件
/// 
/// 显示shouye.png作为首页底图
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 背景图案 Widget
/// 
/// 使用Image.asset显示首页底图
/// 填充整个可用空间
class BackgroundPatternWidget extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键
  const BackgroundPatternWidget({super.key});

  /// 构建背景图案 UI
  /// 
  /// 使用Image.asset显示shouye.png
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: Image Widget，显示背景图片
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/shouye.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        // 如果图片加载失败，显示青色背景作为后备
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.tealBackground,
          child: const Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}