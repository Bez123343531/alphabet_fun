/// 首页展示页面
/// 
/// 这是应用的主页面，展示教育游戏的主界面
/// 使用纯图片展示，无代码生成图形
/// 
/// 主要功能：
/// - 背景图片：shouye.png（全屏覆盖）
/// - 左上角：zhangyu.png（信息图标上层）
/// - 右上角：hong.png
/// - 右下角：more_card.png（替换了原轮盘菜单位置）
/// - 信息按钮：左上角圆形信息图标
/// 
/// 使用 Stack 布局实现元素的层叠效果
/// 所有图片都包含错误处理，确保加载失败时显示友好的错误提示
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_colors.dart';

/// 首页组件
/// 
/// 简化版本，使用现有图片替代代码生成图形：
/// - 背景：使用 shouye.png
/// - 左上角：zhangyu.png（位于信息图标上层）
/// - 右上角：hong.png
/// - 右下角：more_card.png（位于轮盘菜单上层）
/// - 导航：轮盘菜单
/// 
/// 使用 Stack 布局实现元素的层叠效果
class HomePage extends StatelessWidget {
  /// 构造函数
  const HomePage({super.key});

  /// 构建页面 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealBackground,
      body: Stack(
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
          
          // ==================== 左上角区域 ====================
          /// zhangyu.png 位于信息图标上层
          Positioned(
            top: 20,
            left: 70, // 避开信息图标
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
                  image: AssetImage('assets/images/zhangyu.png'),
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
          /// 左上角信息图标（位于 zhangyu.png 下层）
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
          
          // ==================== 右下角 more_card.png ====================
          /// more_card.png 替换轮盘菜单位置
          Positioned(
            right: 20,
            bottom: 24,
            child: GestureDetector(
              onTap: () {
                // TODO: 处理 more_card.png 点击事件
              },
              child: Container(
                width: 100,
                height: 100,
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
        ],
      ),
    );
  }
}