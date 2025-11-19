/// 应用主题配置
/// 
/// 提供应用的主题配置和颜色常量定义
/// 使用 Material 3 设计规范
import 'package:flutter/material.dart';

/// 应用主题类
/// 
/// 负责定义应用的主题配置，包括颜色方案、字体等
/// 所有颜色值基于设计稿中的实际颜色定义
class AppTheme {
  // ==================== 私有颜色常量 ====================
  /// 橙色怪物主体颜色（#FF8C42）
  static const Color _orangeMonster = Color(0xFFFF8C42);
  
  /// 浅橙色（用于怪物角和细节，如角、高光等）
  static const Color _lightOrange = Color(0xFFFFB366);
  
  /// 青色背景色（#2D5A6B），用于应用主背景
  static const Color _tealBackground = Color(0xFF2D5A6B);
  
  /// 紫色领结颜色（#9B59B6），用于怪物底部的领结装饰
  static const Color _purpleBowTie = Color(0xFF9B59B6);
  
  /// 棕色文字颜色（#8B4513），用于单词显示
  static const Color _brownText = Color(0xFF8B4513);
  
  /// 粉色等级标识颜色（#FFB6C1），用于显示关卡等级
  static const Color _pinkLevel = Color(0xFFFFB6C1);
  
  /// 蓝色小怪物颜色（#87CEEB），用于单词卡片中的插图
  static const Color _blueMonster = Color(0xFF87CEEB);
  
  /// 红色鸡舍颜色（#DC143C），用于单词卡片中的鸡舍插图
  static const Color _redCoop = Color(0xFFDC143C);
  
  /// 浅蓝色（#ADD8E6），用于信息图标背景等
  static const Color _lightBlue = Color(0xFFADD8E6);

  // ==================== 主题配置 ====================
  
  /// 获取浅色主题配置
  /// 
  /// 返回配置好的 Material 3 主题数据
  /// - 使用橙色作为种子颜色生成颜色方案
  /// - 设置背景色为青色
  /// - 使用 Roboto 字体
  /// 
  /// Returns: 配置完成的 ThemeData 对象
  static ThemeData get lightTheme {
    return ThemeData(
      // 启用 Material 3 设计规范
      useMaterial3: true,
      // 从种子颜色生成完整的颜色方案
      colorScheme: ColorScheme.fromSeed(
        seedColor: _orangeMonster,
        brightness: Brightness.light,
      ),
      // 设置脚手架背景色为青色
      scaffoldBackgroundColor: _tealBackground,
      // 设置默认字体为 Roboto
      fontFamily: 'Roboto',
    );
  }

  // ==================== 公开颜色常量 ====================
  /// 橙色怪物颜色（公开访问）
  static const Color orangeMonster = _orangeMonster;
  
  /// 浅橙色（公开访问）
  static const Color lightOrange = _lightOrange;
  
  /// 青色背景色（公开访问）
  static const Color tealBackground = _tealBackground;
  
  /// 紫色领结颜色（公开访问）
  static const Color purpleBowTie = _purpleBowTie;
  
  /// 棕色文字颜色（公开访问）
  static const Color brownText = _brownText;
  
  /// 粉色等级标识颜色（公开访问）
  static const Color pinkLevel = _pinkLevel;
  
  /// 蓝色小怪物颜色（公开访问）
  static const Color blueMonster = _blueMonster;
  
  /// 红色鸡舍颜色（公开访问）
  static const Color redCoop = _redCoop;
  
  /// 浅蓝色（公开访问）
  static const Color lightBlue = _lightBlue;
}

