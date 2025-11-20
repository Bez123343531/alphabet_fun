/// 应用主入口文件
/// 
/// 这是 Flutter 应用的入口点
/// 负责初始化应用并配置主题和路由
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_page.dart';

/// 应用主函数
/// 
/// Flutter 应用的入口点
/// 创建并运行 MyApp Widget
void main() {
  runApp(const MyApp());
}

/// 应用根 Widget
/// 
/// 负责配置应用的基本设置：
/// - 应用标题
/// - 主题配置
/// - 首页路由
/// - 调试横幅显示
class MyApp extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键，用于在 widget 树中识别此 widget
  const MyApp({super.key});

  /// 构建应用根 Widget
  /// 
  /// 创建 MaterialApp，配置主题和首页
  /// 
  /// [context] - BuildContext
  /// 
  /// Returns: MaterialApp Widget，应用的根组件
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphabet Fun',              // 应用标题
      theme: AppTheme.lightTheme,         // 使用应用主题配置（Material 3）
      home: const HomePage(
        showDebugOverlay: true,           // 启用调试坐标网格
      ),                                  // 设置首页为 HomePage
      debugShowCheckedModeBanner: false, // 隐藏调试横幅（右上角的 "DEBUG" 标签）
    );
  }
}
