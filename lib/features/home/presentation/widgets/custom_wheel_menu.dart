/// 可展开的轮盘菜单组件（首页右下角）
///
/// 参考示例代码实现交互动画：
/// - 中心按钮控制展开/收起
/// - 展开后显示 1 / 2 / 3 / MORE / ALL 五个选项
/// - 支持外部回调：全选、数字选项、MORE 子菜单
import 'dart:math' as math; // 引入数学库，用于三角函数和常量计算

import 'package:flutter/material.dart'; // Flutter UI 核心包

import '../../../../core/theme/app_colors.dart'; // 主题色定义

/// 轮盘菜单组件
///
/// 该组件本身只负责展示和交互，具体业务通过回调向外暴露：
/// - [onAllSelected]      选中 ALL 时触发
/// - [onNumberSelected]   选中 1 / 2 / 3 时触发
/// - [moreOptions]        MORE 子菜单的文案列表
/// - [onMoreOptionSelected] 选中 MORE 子菜单项时触发
class CustomWheelMenu extends StatefulWidget { // 轮盘菜单 StatefulWidget，处理展开/收起状态
  /// 选中 ALL 时的回调
  final VoidCallback? onAllSelected;

  /// 选中数字 1 / 2 / 3 时的回调
  final ValueChanged<int>? onNumberSelected;

  /// MORE 子菜单的选项列表
  final List<String> moreOptions;

  /// 选中 MORE 子菜单中某个选项时的回调
  final ValueChanged<String>? onMoreOptionSelected;

  const CustomWheelMenu({ // 构造函数
    super.key, // 传递可选的 key
    this.onAllSelected, // 指向 ALL 回调
    this.onNumberSelected, // 指向数字回调
    this.moreOptions = const ['Option 1', 'Option 2', 'Option 3', 'Option 4'], // 默认 MORE 列表
    this.onMoreOptionSelected, // MORE 子项回调
  });

  @override
  State<CustomWheelMenu> createState() => _CustomWheelMenuState(); // 生成状态对象
}

class _CustomWheelMenuState extends State<CustomWheelMenu>
    with SingleTickerProviderStateMixin {
  /// 是否展开轮盘
  bool _isExpanded = false;

  /// 当前选中的索引（0:1, 1:2, 2:3, 3:MORE, 4:ALL）
  int _selectedIndex = 0;

  /// 动画控制器（控制展开/收起）
  late final AnimationController _animationController;

  /// 缩放动画（0 → 1）
  late final Animation<double> _scaleAnimation;

  /// 透明度动画（0 → 1）
  late final Animation<double> _opacityAnimation;

  /// 轮盘选项配置
  /// 文案只用于显示，具体含义由业务回调决定
  /// 顺序与角度严格对应，确保箭头和按钮位置一致
  final List<_WheelOption> _options = const [
    _WheelOption(text: '1', angleDegrees: -144), // 选项 1，位于左上
    _WheelOption(text: '2', angleDegrees: -72), // 选项 2，位于左偏上
    _WheelOption(text: '3', angleDegrees: 0), // 选项 3，位于正右
    _WheelOption(text: 'MORE', angleDegrees: 72), // MORE，位于右下
    _WheelOption(text: 'ALL', angleDegrees: 144), // ALL，位于左下
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController( // 初始化动画控制器
      vsync: this, // 使用当前 State 作为 ticker
      duration: const Duration(milliseconds: 280), // 动画时长 280ms
    );

    _scaleAnimation = CurvedAnimation( // 缩放动画
      parent: _animationController, // 依赖控制器
      curve: Curves.easeOutBack, // 使用回弹曲线
    );

    _opacityAnimation = CurvedAnimation( // 透明度动画
      parent: _animationController, // 使用相同控制器
      curve: Curves.easeOut, // 平滑渐显
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 切换展开/收起
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  /// 处理选项点击
  void _onOptionTap(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        widget.onNumberSelected?.call(1);
        break;
      case 1:
        widget.onNumberSelected?.call(2);
        break;
      case 2:
        widget.onNumberSelected?.call(3);
        break;
      case 3:
        _showMoreMenu();
        break;
      case 4:
        widget.onAllSelected?.call();
        break;
    }

    // 点击后可选自动收起，这里略微延迟，避免动画太突兀
    Future<void>.delayed(const Duration(milliseconds: 220), () {
      if (mounted && _isExpanded) {
        _toggleExpand();
      }
    });
  }

  /// 显示 MORE 子菜单
  void _showMoreMenu() {
    if (widget.moreOptions.isEmpty) {
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              // 标题可以后续接入本地化
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'More options',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // 使用 for-in 保持顺序，同时便于后续扩展（如添加图标）
              for (final option in widget.moreOptions)
                ListTile(
                  title: Text(option),
                  onTap: () {
                    widget.onMoreOptionSelected?.call(option);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  /// 箭头指示器（指向当前选中的选项）
  Widget _buildArrowPointer() {
    return Align(
      alignment: const Alignment(0, -1.1),
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 200),
        turns: _options[_selectedIndex].angleDegrees / 360,
        child: Icon(
          Icons.arrow_downward,
          size: 28,
          color: Colors.black.withOpacity(0.8),
          shadows: const [
            Shadow(color: Colors.white, blurRadius: 2),
          ],
        ),
      ),
    );
  }

  /// 中层选项按钮（1 / 2 / 3 / MORE / ALL）
  Widget _buildOptions() {
    const double wheelRadius = 90; // 相对于中心的半径
    const double optionSize = 40;  // 每个按钮的尺寸

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // 使用透明度 + 缩放双动画，让展开/收起更顺滑
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              children: _options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                final angleRad = option.angleDegrees * math.pi / 180;

                // 极坐标 → 直角坐标（以中心为原点）
                final offset = Offset(
                  wheelRadius * math.cos(angleRad),
                  wheelRadius * math.sin(angleRad),
                );

                return Transform.translate(
                  offset: offset,
                  child: GestureDetector(
                    onTap: () => _onOptionTap(index),
                    child: Container(
                      width: optionSize,
                      height: optionSize,
                      decoration: BoxDecoration(
                        color: _resolveOptionColor(index),
                        borderRadius: BorderRadius.circular(optionSize / 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                          ),
                        ],
                        border: _selectedIndex == index
                            ? Border.all(color: Colors.black87, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          option.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  /// 底层圆环背景
  Widget _buildBottomRing() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.lightOrange.withOpacity(0.3),
                borderRadius: BorderRadius.circular(110),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 中心按钮（控制展开/收起）
  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.orangeMonster,
          borderRadius: BorderRadius.circular(36),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 8,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            _isExpanded ? Icons.close : Icons.menu,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  /// 根据索引返回对应按钮颜色（使用主题色系）
  Color _resolveOptionColor(int index) {
    switch (index) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.greenAccent;
      case 3:
        return AppColors.orangeMonster;
      case 4:
      default:
        return AppColors.purpleBowTie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isExpanded) _buildBottomRing(),
          if (_isExpanded) _buildOptions(),
          if (_isExpanded) _buildArrowPointer(),
          _buildCenterButton(),
        ],
      ),
    );
  }
}

/// 内部使用的轮盘选项模型
class _WheelOption {
  /// 按钮上显示的文字
  final String text;

  /// 该选项距离 X 轴的角度（度数制，0° 代表朝右）
  /// 顺时针正方向，便于与设计稿保持一致
  final double angleDegrees;

  const _WheelOption({
    required this.text,
    required this.angleDegrees,
  });
}