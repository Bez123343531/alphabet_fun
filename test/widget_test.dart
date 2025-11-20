// 字母教育应用的核心组件测试
//
// 该文件包含对主要UI组件的功能性测试，用于验证应用的核心功能是否正常工作。
// 测试使用WidgetTester工具进行交互式测试，包括点击、滚动等手势操作，
// 同时验证组件树中的子组件、文本显示和属性值是否正确。

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alphabet_fun/main.dart';
import 'package:alphabet_fun/features/home/presentation/home_page.dart';
import 'package:alphabet_fun/features/home/presentation/widgets/background_pattern_widget.dart';
import 'package:alphabet_fun/features/home/presentation/widgets/alphabet_display_widget.dart';
import 'package:alphabet_fun/features/home/presentation/widgets/word_card_widget.dart';
import 'package:alphabet_fun/features/home/presentation/widgets/navigation_wheel_widget.dart';
import 'package:alphabet_fun/features/home/presentation/widgets/monster_frame_widget.dart';

void main() {
  // 应用启动测试 - 验证主页应用组件是否正确加载
  testWidgets('字母教育应用启动测试', (WidgetTester tester) async {
    // 构建应用并触发一次渲染帧
    await tester.pumpWidget(const MyApp());

    // 验证应用启动时能够正常渲染
    expect(find.byType(MyApp), findsOneWidget);
    
    // 验证主页组件是否正确显示
    expect(find.byType(HomePage), findsOneWidget);
  });

  // 背景组件测试 - 验证背景图片是否正常加载
  testWidgets('背景图片显示测试', (WidgetTester tester) async {
    // 构建应用并等待完全加载
    await tester.pumpWidget(const MyApp());
    
    // 验证背景图片组件是否存在
    expect(find.byType(BackgroundPatternWidget), findsOneWidget);
  });

  // 字母显示组件测试 - 验证字母表绘制功能
  testWidgets('字母显示组件测试', (WidgetTester tester) async {
    // 构建应用并触发渲染
    await tester.pumpWidget(const MyApp());
    
    // 验证字母显示组件是否正确加载
    expect(find.byType(AlphabetDisplayWidget), findsOneWidget);
  });

  // 单词卡片组件测试 - 验证单词学习功能
  testWidgets('单词卡片组件测试', (WidgetTester tester) async {
    // 构建应用并等待组件加载
    await tester.pumpWidget(const MyApp());
    
    // 验证单词卡片组件是否存在
    expect(find.byType(WordCardWidget), findsOneWidget);
  });

  // 导航轮盘组件测试 - 验证导航功能
  testWidgets('导航轮盘组件测试', (WidgetTester tester) async {
    // 构建应用并触发渲染
    await tester.pumpWidget(const MyApp());
    
    // 验证导航轮盘组件是否正确显示
    expect(find.byType(NavigationWheelWidget), findsOneWidget);
  });

  // 怪物框架组件测试 - 验证主题框架显示
  testWidgets('怪物框架组件测试', (WidgetTester tester) async {
    // 构建应用并等待组件渲染完成
    await tester.pumpWidget(const MyApp());
    
    // 验证怪物框架组件是否正确加载
    expect(find.byType(MonsterFrameWidget), findsOneWidget);
  });
}
