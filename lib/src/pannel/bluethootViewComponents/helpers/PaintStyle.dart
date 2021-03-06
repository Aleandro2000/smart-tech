import 'dart:ui';

class PaintStyle {
  final bool isAntiAlias;
  static const int _kColorDefault = 0xFF000000;
  final Color? color;
  static final int _kBlendModeDefault = BlendMode.srcOver.index;
  final BlendMode blendMode;
  final PaintingStyle style;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  static const double _kStrokeMiterLimitDefault = 4.0;
  final double strokeMiterLimit;
  final MaskFilter? maskFilter;
  final FilterQuality filterQuality;
  final Shader? shader;
  final ColorFilter? colorFilter;
  final bool invertColors;

  const PaintStyle({
    this.isAntiAlias = true,
    this.color = const Color(_kColorDefault),
    this.blendMode = BlendMode.srcOver,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 0.0,
    this.strokeCap = StrokeCap.butt,
    this.strokeJoin = StrokeJoin.miter,
    this.strokeMiterLimit = 4.0,
    this.maskFilter,
    this.filterQuality = FilterQuality.none,
    this.shader,
    this.colorFilter,
    this.invertColors = false,
  });

  @override
  String toString() {
    final StringBuffer result = StringBuffer();
    String semicolon = '';
    result.write('PaintStyle(');
    if (style == PaintingStyle.stroke) {
      result.write('$style');
      if (strokeWidth != 0.0) {
        result.write(' ${strokeWidth.toStringAsFixed(1)}');
      } else {
        result.write(' hairline');
      }
      if (strokeCap != StrokeCap.butt) result.write(' $strokeCap');
      if (strokeJoin == StrokeJoin.miter) {
        if (strokeMiterLimit != _kStrokeMiterLimitDefault) {
          result.write(
              ' $strokeJoin up to ${strokeMiterLimit.toStringAsFixed(1)}');
        }
      } else {
        result.write(' $strokeJoin');
      }
      semicolon = '; ';
    }
    if (isAntiAlias != true) {
      result.write('${semicolon}antialias off');
      semicolon = '; ';
    }
    if (color != const Color(_kColorDefault)) {
      if (color != null) {
        result.write('$semicolon$color');
      } else {
        result.write('${semicolon}no color');
      }
      semicolon = '; ';
    }
    if (blendMode.index != _kBlendModeDefault) {
      result.write('$semicolon$blendMode');
      semicolon = '; ';
    }
    if (colorFilter != null) {
      result.write('${semicolon}colorFilter: $colorFilter');
      semicolon = '; ';
    }
    if (maskFilter != null) {
      result.write('${semicolon}maskFilter: $maskFilter');
      semicolon = '; ';
    }
    if (filterQuality != FilterQuality.none) {
      result.write('${semicolon}filterQuality: $filterQuality');
      semicolon = '; ';
    }
    if (shader != null) {
      result.write('${semicolon}shader: $shader');
      semicolon = '; ';
    }
    if (invertColors) result.write('${semicolon}invert: $invertColors');
    result.write(')');
    return result.toString();
  }

  Paint toPaint() {
    Paint paint = Paint();
    if (isAntiAlias != true) paint.isAntiAlias = isAntiAlias;
    if (color != const Color(_kColorDefault)) paint.color = color!;
    if (blendMode != BlendMode.srcOver) paint.blendMode = blendMode;
    if (style != PaintingStyle.fill) paint.style = style;
    if (strokeWidth != 0.0) paint.strokeWidth = strokeWidth;
    if (strokeCap != StrokeCap.butt) paint.strokeCap = strokeCap;
    if (strokeJoin != StrokeJoin.miter) paint.strokeJoin = strokeJoin;
    if (strokeMiterLimit != 4.0) paint.strokeMiterLimit = strokeMiterLimit;
    if (maskFilter != null) paint.maskFilter = maskFilter;
    if (filterQuality != FilterQuality.none) {
      paint.filterQuality = filterQuality;
    }
    if (shader != null) paint.shader = shader;
    if (colorFilter != null) paint.colorFilter = colorFilter;
    if (invertColors != false) paint.invertColors = invertColors;
    return paint;
  }
}
