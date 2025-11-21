/// 透明图片 Widget，确保 Alpha 通道正确处理
/// 使用 CustomPaint 绘制图片，避免黑色透明背景问题
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 透明图片 Widget，确保 Alpha 通道正确处理
/// 使用 CustomPaint 绘制图片，避免黑色透明背景问题
class TransparentImage extends StatefulWidget {
  const TransparentImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
    this.errorBuilder,
  });

  final String imagePath;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;

  @override
  State<TransparentImage> createState() => _TransparentImageState();
}

class _TransparentImageState extends State<TransparentImage> {
  ui.Image? _image;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final ByteData data = await rootBundle.load(widget.imagePath);
      final Uint8List bytes = data.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: widget.fit == BoxFit.cover ? null : 1000,
        targetHeight: widget.fit == BoxFit.cover ? null : 1000,
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          _image = frameInfo.image;
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        if (widget.errorBuilder != null) {
          widget.errorBuilder!(context, e, stackTrace);
        }
      }
    }
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError && widget.errorBuilder != null) {
      return widget.errorBuilder!(
        context,
        Exception('Failed to load image'),
        StackTrace.current,
      );
    }

    if (_isLoading || _image == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomPaint(
      painter: _TransparentImagePainter(
        image: _image!,
        fit: widget.fit,
        filterQuality: widget.filterQuality,
      ),
      size: Size.infinite,
    );
  }
}

class _TransparentImagePainter extends CustomPainter {
  _TransparentImagePainter({
    required this.image,
    required this.fit,
    required this.filterQuality,
  });

  final ui.Image image;
  final BoxFit fit;
  final FilterQuality filterQuality;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect imageRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final Rect outputRect = Offset.zero & size;

    final Rect? srcRect;
    final Rect? dstRect;

    switch (fit) {
      case BoxFit.cover:
        final FittedSizes fittedSizes = applyBoxFit(fit, imageRect.size, outputRect.size);
        final double scaleX = fittedSizes.destination.width / fittedSizes.source.width;
        final double scaleY = fittedSizes.destination.height / fittedSizes.source.height;
        final double scale = scaleX > scaleY ? scaleX : scaleY;
        final Size scaledSize = imageRect.size * scale;
        final Alignment alignment = Alignment.center;
        dstRect = alignment.inscribe(scaledSize, outputRect);
        srcRect = imageRect;
        break;
      case BoxFit.contain:
        final FittedSizes fittedSizes = applyBoxFit(fit, imageRect.size, outputRect.size);
        final Alignment alignment = Alignment.center;
        dstRect = alignment.inscribe(fittedSizes.destination, outputRect);
        srcRect = imageRect;
        break;
      case BoxFit.fill:
        srcRect = imageRect;
        dstRect = outputRect;
        break;
      case BoxFit.fitWidth:
      case BoxFit.fitHeight:
      case BoxFit.none:
      case BoxFit.scaleDown:
        srcRect = imageRect;
        dstRect = outputRect;
        break;
    }

    final Paint paint = Paint()
      ..filterQuality = filterQuality
      ..isAntiAlias = true
      ..blendMode = BlendMode.srcOver;

    // 直接绘制图片，BlendMode.srcOver 会正确处理 Alpha 通道
    canvas.drawImageRect(
      image,
      srcRect ?? imageRect,
      dstRect ?? outputRect,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _TransparentImagePainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.fit != fit ||
        oldDelegate.filterQuality != filterQuality;
  }
}

