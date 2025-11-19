/// 首页展示页面
/// 
/// 这是应用的主页面，展示教育游戏的主界面
/// 包含怪物框架、字母表、单词卡片、导航轮等组件
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/background_pattern_widget.dart';
import 'widgets/monster_frame_widget.dart';
import 'widgets/alphabet_display_widget.dart';
import 'widgets/word_card_widget.dart';
import 'widgets/custom_wheel_menu.dart';

/// 首页组件
/// 
/// 负责整合和展示所有首页元素：
/// - 背景图案
/// - 信息图标
/// - 怪物框架（包含字母表和单词卡片）
/// - 导航轮
/// 
/// 使用 Stack 布局实现元素的层叠效果
class HomePage extends StatelessWidget {
  /// 构造函数
  /// 
  /// [key] - Widget 的键，用于在 widget 树中识别此 widget
  const HomePage({super.key});

  /// 构建页面 UI
  /// 
  /// 使用 Stack 布局将所有元素叠加在一起：
  /// 1. 最底层：背景图案
  /// 2. 信息图标：左上角
  /// 3. 怪物框架：包含字母表和单词卡片
  /// 4. 导航轮：右下角
  /// 
  /// [context] - BuildContext，用于获取主题、媒体查询等信息
  /// 
  /// Returns: 构建完成的 Widget 树
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置背景色为青色，与主题保持一致
      backgroundColor: AppColors.tealBackground,
      body: Stack(
        children: [
          // ==================== 背景层 ====================
          /// 背景图案组件
          /// 绘制青色背景和纹理图案
          const BackgroundPatternWidget(),
          
          // ==================== 信息图标 ====================
          /// 左上角信息图标
          /// 点击可显示应用信息或帮助
          Positioned(
            top: 20,  // 距离顶部 20 像素
            left: 20, // 距离左侧 20 像素
            child: GestureDetector(
              onTap: () {
                // TODO: 处理信息图标点击事件
                // 可以显示关于页面、帮助信息等
              },
              child: Container(
                width: 40,   // 图标容器宽度
                height: 40, // 图标容器高度
                decoration: BoxDecoration(
                  color: AppColors.lightBlue, // 浅蓝色背景
                  shape: BoxShape.circle,     // 圆形
                ),
                child: const Icon(
                  Icons.info,              // 信息图标
                  color: AppColors.white,   // 白色图标
                  size: 24,                // 图标大小
                ),
              ),
            ),
          ),
          
          // ==================== 主要内容区域 ====================
          /// 怪物框架组件
          /// 这是页面的核心元素，包含：
          /// - 橙色怪物框架（三眼、双角、紫色领结）
          /// - 字母表显示（沿弧形路径）
          /// - 中央单词卡片
          MonsterFrameWidget(
            child: Stack(
              children: [
                // 字母表显示组件
                // 在怪物框架的弧形路径上显示 a-z 字母
                const Positioned.fill(
                  child: AlphabetDisplayWidget(),
                ),
                
                // 中央单词卡片组件
                // 显示当前学习的单词、插图和等级
                Center(
                  child: SizedBox(
                    // 卡片宽度为屏幕宽度的 50%
                    width: MediaQuery.of(context).size.width * 0.5,
                    // 卡片高度为屏幕高度的 60%
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const WordCardWidget(
                      word: 'basket', // 当前显示的单词
                      level: 3,      // 当前等级
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // ==================== 导航层 ====================
          /// 右下角轮盘菜单组件
          /// 参考示例代码，实现可展开的 1 / 2 / 3 / MORE / ALL 轮盘交互
          Positioned(
            right: 20,
            bottom: 24,
            child: CustomWheelMenu(
              onAllSelected: () {
                // TODO: 处理 ALL 选项的点击，例如切换到全部关卡
              },
              onNumberSelected: (number) {
                // TODO: 根据 number 切换不同难度或关卡
              },
              moreOptions: const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
              onMoreOptionSelected: (option) {
                // TODO: 处理 MORE 子菜单点击
              },
            ),
          ),
        ],
      ),
    );
  }
}

