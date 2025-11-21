/// 基于设计稿 PNG 的罗盘菜单，支持 5 个透明点击区与旋转指针。
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transparent_image_widget.dart';

const String _kCompassAssetPath = 'assets/images/more_card.png';
const double _kInnerRadiusRatio = 0.55;
const double _kStartAngleDeg = -162;
const double _kSegmentSweepDeg = 72;

class CustomWheelMenu extends StatefulWidget {
  const CustomWheelMenu({
    super.key,
    this.onAllSelected,
    this.onNumberSelected,
    this.moreOptions = const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    this.onMoreOptionSelected,
  });

  final VoidCallback? onAllSelected;
  final ValueChanged<int>? onNumberSelected;
  final List<String> moreOptions;
  final ValueChanged<String>? onMoreOptionSelected;

  @override
  State<CustomWheelMenu> createState() => _CustomWheelMenuState();
}

class _CustomWheelMenuState extends State<CustomWheelMenu>
    with SingleTickerProviderStateMixin {
  late final List<_CompassSegment> _segments;
  late final AnimationController _pointerController;
  Animation<double>? _pointerAnimation;

  int _selectedIndex = 4;
  late double _pointerAngle;

  @override
  void initState() {
    super.initState();
    _segments = _buildSegments();
    _pointerAngle = _segments[_selectedIndex].centerAngle;
    _pointerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void dispose() {
    _pointerController.dispose();
    super.dispose();
  }

  List<_CompassSegment> _buildSegments() {
    final double startRad = _degreesToRadians(_kStartAngleDeg);
    final double sweepRad = _degreesToRadians(_kSegmentSweepDeg);
    final labels = ['ALL', '1', '2', '3', 'MORE'];
    return List<_CompassSegment>.generate(labels.length, (index) {
      final String label = labels[index];
      return _CompassSegment(
        label: label,
        startAngle: startRad + index * sweepRad,
        sweepAngle: sweepRad,
        type: switch (label) {
          'ALL' => _SegmentType.all,
          'MORE' => _SegmentType.more,
          _ => _SegmentType.number,
        },
        numberValue: int.tryParse(label),
      );
    });
  }

  void _selectSegment(int index) {
    if (_selectedIndex == index) {
      _triggerCallbacks(index);
      return;
    }
    final double targetAngle = _segments[index].centerAngle;
    _pointerAnimation = Tween<double>(
      begin: _pointerAngle,
      end: targetAngle,
    ).animate(
      CurvedAnimation(parent: _pointerController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() => _pointerAngle = _pointerAnimation!.value);
      });
    _pointerController.forward(from: 0);
    _selectedIndex = index;
    _triggerCallbacks(index);
  }

  void _triggerCallbacks(int index) {
    final segment = _segments[index];
    switch (segment.type) {
      case _SegmentType.all:
        widget.onAllSelected?.call();
        break;
      case _SegmentType.number:
        final value = segment.numberValue;
        if (value != null) {
          widget.onNumberSelected?.call(value);
        }
        break;
      case _SegmentType.more:
        _showMoreSheet();
        break;
    }
  }

  void _showMoreSheet() {
    if (widget.moreOptions.isEmpty) return;
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
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
      ),
    );
  }

  List<Widget> _buildSegmentButtons() {
    return List<Widget>.generate(_segments.length, (index) {
      final segment = _segments[index];
      return Positioned.fill(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: _AnnularSegmentBorder(
              startAngle: segment.startAngle,
              sweepAngle: segment.sweepAngle,
              innerRadiusRatio: _kInnerRadiusRatio,
            ),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.2),
            onTap: () => _selectSegment(index),
            onTapDown: (_) => _handleTapDown(index),
            onTapUp: (_) => _handleTapUp(index),
            onTapCancel: _handleTapCancel,
          ),
        ),
      );
    });
  }

  void _handleTapDown(int index) {
    // 触觉反馈（如果设备支持）
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(int index) {
    // 恢复轮盘菜单的正常状态
  }

  void _handleTapCancel() {
    // 恢复轮盘菜单的正常状态
  }

  @override
  Widget build(BuildContext context) {
    const double defaultSize = 240;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dimension = math.min(
          constraints.hasBoundedWidth ? constraints.maxWidth : defaultSize,
          constraints.hasBoundedHeight ? constraints.maxHeight : defaultSize,
        );
        return SizedBox(
          width: dimension,
          height: dimension,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: dimension,
                height: dimension,
                child: TransparentImage(
                  imagePath: _kCompassAssetPath,
                  fit: BoxFit.contain,
                ),
              ),
              ..._buildSegmentButtons(),
              IgnorePointer(
                child: CustomPaint(
                  size: Size.square(dimension),
                  painter: _PointerPainter(
                    pointerAngle: _pointerAngle,
                    innerRadiusRatio: _kInnerRadiusRatio,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PointerPainter extends CustomPainter {
  const _PointerPainter({
    required this.pointerAngle,
    required this.innerRadiusRatio,
  });

  final double pointerAngle;
  final double innerRadiusRatio;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double innerRadius = size.width / 2 * innerRadiusRatio;
    final double pointerLength = innerRadius * 0.95;
    final double pointerWidth = innerRadius * 0.18;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pointerAngle);

    final Paint pointerPaint = Paint()..color = Colors.white;
    final Path pointerPath = Path()
      ..moveTo(-pointerWidth * 0.2, 0)
      ..lineTo(pointerLength, 0)
      ..lineTo(pointerLength - pointerWidth, pointerWidth * 0.6)
      ..lineTo(pointerLength - pointerWidth, -pointerWidth * 0.6)
      ..close();
    canvas.drawPath(pointerPath, pointerPaint);

    final Path starPath = _buildStarPath(
      center: Offset(-pointerWidth * 0.8, 0),
      radius: pointerWidth * 0.5,
    );
    canvas.drawPath(starPath, pointerPaint);

    canvas.drawCircle(
      Offset.zero,
      pointerWidth * 0.35,
      Paint()..color = Colors.orange.shade200,
    );
    canvas.restore();
  }

  Path _buildStarPath({required Offset center, required double radius}) {
    final Path path = Path();
    const int points = 5;
    for (int i = 0; i <= points * 2; i++) {
      final double angle = i * math.pi / points;
      final double currentRadius = i.isEven ? radius : radius / 2;
      final Offset point = Offset(
        center.dx + currentRadius * math.cos(angle),
        center.dy + currentRadius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path..close();
  }

  @override
  bool shouldRepaint(covariant _PointerPainter oldDelegate) {
    return oldDelegate.pointerAngle != pointerAngle;
  }
}

class _AnnularSegmentBorder extends ShapeBorder {
  const _AnnularSegmentBorder({
    required this.startAngle,
    required this.sweepAngle,
    required this.innerRadiusRatio,
  });

  final double startAngle;
  final double sweepAngle;
  final double innerRadiusRatio;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => _createPath(rect);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => _createPath(rect);

  Path _createPath(Rect rect) {
    final Offset center = rect.center;
    final double outerRadius = rect.width / 2;
    final double innerRadius = outerRadius * innerRadiusRatio;
    final Rect outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final Rect innerRect = Rect.fromCircle(center: center, radius: innerRadius);
    return Path()
      ..arcTo(outerRect, startAngle, sweepAngle, false)
      ..arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false)
      ..close();
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) => _AnnularSegmentBorder(
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        innerRadiusRatio: innerRadiusRatio,
      );

  @override
  ShapeBorder lerpFrom(ShapeBorder? a, double t) => this;

  @override
  ShapeBorder lerpTo(ShapeBorder? b, double t) => this;

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // 无需绘制实体，仅用于定义 InkWell 命中区域
  }
}

class _CompassSegment {
  const _CompassSegment({
    required this.label,
    required this.startAngle,
    required this.sweepAngle,
    required this.type,
    this.numberValue,
  });

  final String label;
  final double startAngle;
  final double sweepAngle;
  final _SegmentType type;
  final int? numberValue;

  double get centerAngle => startAngle + sweepAngle / 2;
}

enum _SegmentType { all, number, more }

double _degreesToRadians(double degrees) => degrees * math.pi / 180;