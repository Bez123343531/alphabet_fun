/// 应用颜色常量定义
/// 
/// 集中管理应用中使用的所有颜色常量
/// 便于统一维护和修改颜色方案
import 'package:flutter/material.dart';

/// 应用颜色类
/// 
/// 提供应用中使用的所有颜色常量
/// 使用私有构造函数防止实例化，所有颜色都是静态常量
class AppColors {
  /// 私有构造函数，防止实例化
  /// 此类仅用于提供静态颜色常量
  AppColors._();

  // ==================== 主要颜色 ====================
  
  /// 橙色怪物主体颜色（#FF8C42）
  /// 用于怪物框架的主要颜色
  static const Color orangeMonster = Color(0xFFFF8C42);
  
  /// 浅橙色（#FFB366）
  /// 用于怪物角、高光等细节装饰
  static const Color lightOrange = Color(0xFFFFB366);
  
  /// 青色背景色（#2D5A6B）
  /// 用于应用的主背景色
  static const Color tealBackground = Color(0xFF2D5A6B);
  
  /// 紫色领结颜色（#9B59B6）
  /// 用于怪物底部的领结装饰
  static const Color purpleBowTie = Color(0xFF9B59B6);
  
  /// 棕色文字颜色（#8B4513）
  /// 用于单词显示和篮子等元素
  static const Color brownText = Color(0xFF8B4513);
  
  /// 粉色等级标识颜色（#FFB6C1）
  /// 用于显示关卡等级标签
  static const Color pinkLevel = Color(0xFFFFB6C1);
  
  /// 蓝色小怪物颜色（#87CEEB）
  /// 用于单词卡片中的小怪物插图
  static const Color blueMonster = Color(0xFF87CEEB);
  
  /// 红色鸡舍颜色（#DC143C）
  /// 用于单词卡片中的鸡舍插图
  static const Color redCoop = Color(0xFFDC143C);
  
  /// 浅蓝色（#ADD8E6）
  /// 用于信息图标背景等辅助元素
  static const Color lightBlue = Color(0xFFADD8E6);
  
  // ==================== 基础颜色 ====================
  
  /// 白色（#FFFFFF）
  /// 用于文字、背景等
  static const Color white = Color(0xFFFFFFFF);
  
  /// 黑色（#000000）
  /// 用于文字、描边等
  static const Color black = Color(0xFF000000);
}

