/// @name LineChart
/// @version 0.0.5
/// @description Simple line chart widget
/// @author Patryk "PsychoX" Ludwikowski <patryk.ludwikowski.7+dart@gmail.com>
/// @license MIT License (see https://mit-license.org/)
import 'dart:math' as math show min, max;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import './PaintStyle.dart';

class LabelEntry {
  final double value;
  final String label;

  LabelEntry(this.value, this.label);
}

class LineChart extends StatelessWidget {
  final BoxConstraints constraints;
  final EdgeInsets padding;
  final Iterable<double> arguments;
  final Iterable<LabelEntry> argumentsLabels;
  final Iterable<Iterable<double>> values;
  final Iterable<LabelEntry>? valuesLabels;
  final TextStyle? horizontalLabelsTextStyle;
  final TextStyle? verticalLabelsTextStyle;
  final Paint? horizontalLinesPaint;
  final Paint? verticalLinesPaint;

  final bool snapToLeftLabel = false;
  final bool snapToTopLabel = true;
  final bool snapToRightLabel = false;
  final bool snapToBottomLabel = true;
  final List<Paint?> seriesPointsPaints;
  final List<Paint>? seriesLinesPaints;

  final double additionalMinimalHorizontalLabelsInterval;
  final double additionalMinimalVerticalLablesInterval;

  LineChart({
    Key? key,
    required this.constraints,
    this.padding = const EdgeInsets.fromLTRB(32, 12, 20, 28),
    required this.arguments,
    required this.argumentsLabels,
    required this.values,
    this.valuesLabels,
    this.horizontalLabelsTextStyle,
    this.verticalLabelsTextStyle,
    PaintStyle horizontalLinesStyle = const PaintStyle(color: Colors.grey),
    PaintStyle? verticalLinesStyle, // null for default

    this.additionalMinimalHorizontalLabelsInterval = 8,
    this.additionalMinimalVerticalLablesInterval = 8,
    Iterable<PaintStyle?>?
        seriesPointsStyles, // null would use predefined set of styles
    Iterable<PaintStyle>? seriesLinesStyles, // null for default
  })  : horizontalLinesPaint = horizontalLinesStyle.toPaint(),
        verticalLinesPaint = verticalLinesStyle?.toPaint(),
        seriesPointsPaints = _prepareSeriesPointsPaints(seriesPointsStyles),
        seriesLinesPaints = _prepareSeriesLinesPaints(seriesLinesStyles),
        super(key: key) {
    if ((seriesPointsStyles?.length ?? values.length) < values.length &&
        12 /* default paints */ < values.length) {
      throw "Too few `seriesPointsPaintStyle`s! Try define more or limit number of displayed series";
    }
    if ((seriesLinesStyles?.length ?? values.length) < values.length) {
      throw "Too few `seriesLinesStyles`s! Try define more or limit number of displayed series";
    }
  }

  static List<Paint?> _prepareSeriesPointsPaints(
      Iterable<PaintStyle?>? seriesPointsStyles) {
    if (seriesPointsStyles == null) {
      // Default paint for points
      return List<Paint?>.unmodifiable(<Paint>[
        const PaintStyle(strokeWidth: 1.7, color: Colors.blue).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.red).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.yellow).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.green).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.purple).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.deepOrange).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.brown).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.lime).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.indigo).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.pink).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.amber).toPaint(),
        const PaintStyle(strokeWidth: 1.7, color: Colors.teal).toPaint(),
      ]);
    } else {
      return seriesPointsStyles.map((style) => style?.toPaint()).toList();
    }
  }

  static List<Paint>? _prepareSeriesLinesPaints(
      Iterable<PaintStyle>? seriesLinesStyles) {
    if (seriesLinesStyles == null) {
      return null;
    } else {
      return seriesLinesStyles.map((style) => style.toPaint()).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: constraints,
        child: CustomPaint(
            painter: _LineChartPainter(
          padding: padding,
          arguments: arguments,
          argumentsLabels: argumentsLabels,
          values: values,
          valuesLabels: valuesLabels,
          horizontalLabelsTextStyle:
              horizontalLabelsTextStyle ?? Theme.of(context).textTheme.caption,
          verticalLabelsTextStyle:
              verticalLabelsTextStyle ?? Theme.of(context).textTheme.caption,
          horizontalLinesPaint: horizontalLinesPaint,
          verticalLinesPaint: verticalLinesPaint,
          additionalMinimalHorizontalLabelsInterval:
              additionalMinimalHorizontalLabelsInterval,
          additionalMinimalVerticalLablesInterval:
              additionalMinimalVerticalLablesInterval,
          seriesPointsPaints: seriesPointsPaints,
          seriesLinesPaints: seriesLinesPaints,
        )));
  }
}

class _LineChartPainter extends CustomPainter {
  final EdgeInsets padding;
  final Iterable<double> arguments;
  final Iterable<LabelEntry>? argumentsLabels;
  final Iterable<Iterable<double>> values;
  final Iterable<LabelEntry>? valuesLabels;
  final TextStyle? horizontalLabelsTextStyle;
  final TextStyle? verticalLabelsTextStyle;
  final Paint? horizontalLinesPaint;
  final Paint? verticalLinesPaint;
  final bool snapToLeftLabel = false;
  final bool snapToTopLabel = true;
  final bool snapToRightLabel = false;
  final bool snapToBottomLabel = true;
  final Iterable<Paint?> seriesPointsPaints;
  final Iterable<Paint>? seriesLinesPaints;
  final double minimalHorizontalLabelsInterval;
  double maxValue = -double.maxFinite;
  double minValue = double.maxFinite;

  double _minimalHorizontalRatio = 0;
  double _minimalVerticalRatio = 0;

  /// Creates `_LineChartPainter` (`CustomPainter`) with given data and styling.
  _LineChartPainter({
    this.padding = const EdgeInsets.fromLTRB(40, 8, 8, 32),
    required this.arguments,
    required this.argumentsLabels,
    required this.values,
    required this.valuesLabels,
    required this.horizontalLabelsTextStyle,
    required this.verticalLabelsTextStyle,
    required this.horizontalLinesPaint,
    required this.verticalLinesPaint,
    double additionalMinimalHorizontalLabelsInterval = 8,
    double additionalMinimalVerticalLablesInterval = 8,
    required this.seriesPointsPaints,
    required this.seriesLinesPaints,
  }) : minimalHorizontalLabelsInterval =
            (horizontalLabelsTextStyle?.fontSize ?? 12) +
                additionalMinimalHorizontalLabelsInterval {
    // Find max & min values of data to be show
    for (Iterable<double> series in values) {
      for (double value in series) {
        if (value > maxValue) {
          maxValue = value;
        } else if (value < minValue) {
          minValue = value;
        }
      }
    }

    if (valuesLabels != null) {
      Iterator<LabelEntry> entry = valuesLabels!.iterator;
      entry.moveNext();
      double lastValue = entry.current.value;

      while (entry.moveNext()) {
        final double goodRatio =
            minimalHorizontalLabelsInterval / (entry.current.value - lastValue);
        if (goodRatio > _minimalVerticalRatio) {
          _minimalVerticalRatio = goodRatio;
        }

        lastValue = entry.current.value;
      }
    }

    if (argumentsLabels != null) {
      Iterator<LabelEntry> entry = argumentsLabels!.iterator;
      entry.moveNext();
      double lastValue = entry.current.value;
      double lastWidth =
          _getLabelTextPainter(entry.current.label, verticalLabelsTextStyle)
              .width;

      while (entry.moveNext()) {
        final double nextValue = entry.current.value;
        final double nextWidth =
            _getLabelTextPainter(entry.current.label, verticalLabelsTextStyle)
                .width;

        final double goodRatio = ((lastWidth + nextWidth) / 2 +
                additionalMinimalVerticalLablesInterval) /
            (nextValue - lastValue);
        if (goodRatio > _minimalHorizontalRatio) {
          _minimalHorizontalRatio = goodRatio;
        }

        lastValue = nextValue;
        lastWidth = nextWidth;
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width - padding.left - padding.right;
    final double height = size.height - padding.top - padding.bottom;

    double valuesOffset = 0;
    double verticalRatio;

    {
      Iterable<LabelEntry> labels;

      if (valuesLabels == null) {
        final double optimalStepValue =
            _calculateOptimalStepValue(maxValue - minValue, height);
        int stepsNumber = 1;

        double bottomValue = 0;
        if (minValue > 0) {
          while (bottomValue < minValue) {
            bottomValue += optimalStepValue;
          }
          bottomValue -= optimalStepValue;
        } else {
          while (bottomValue > minValue) {
            bottomValue -= optimalStepValue;
          }
        }
        valuesOffset = bottomValue;

        double topValue = bottomValue;
        while (topValue < maxValue) {
          topValue += optimalStepValue;
          stepsNumber += 1;
        }

        Iterable<LabelEntry> generator(double optimalStepValue, int stepsNumber,
            [double value = 0.0]) sync* {
          //double value = _bottomValue;
          for (int i = 0; i < stepsNumber; i++) {
            yield LabelEntry(value, value.toString());
            value += optimalStepValue;
          }
        }

        labels = generator(optimalStepValue, stepsNumber, bottomValue);

        if (!snapToTopLabel) {
          topValue = maxValue;
        }
        if (!snapToBottomLabel) {
          bottomValue = valuesOffset = minValue;
        }

        verticalRatio = height / (topValue - bottomValue);
      } else {
        labels = valuesLabels!;

        valuesOffset = minValue;

        final double topValue =
            snapToTopLabel ? math.max(maxValue, labels.last.value) : maxValue;
        final double bottomValue = snapToBottomLabel
            ? math.min(minValue, labels.first.value)
            : minValue;
        final double noEmptySpaceRatio = height / (topValue - bottomValue);
        verticalRatio = math.max(_minimalVerticalRatio, noEmptySpaceRatio);
      }

      for (LabelEntry tuple in labels) {
        if (tuple.value < valuesOffset) continue;
        final double yOffset = (size.height -
            padding.bottom -
            (tuple.value - valuesOffset) * verticalRatio);
        if (yOffset < padding.top) break;

        if (horizontalLinesPaint != null) {
          canvas.drawLine(
              Offset(padding.left, yOffset),
              Offset(size.width - padding.right, yOffset),
              horizontalLinesPaint!);
        }

        TextPainter(
            text: TextSpan(text: tuple.label, style: horizontalLabelsTextStyle),
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr)
          ..layout(minWidth: padding.left - 4)
          ..paint(
              canvas,
              Offset(
                  0,
                  yOffset -
                      (horizontalLabelsTextStyle?.fontSize ?? 12) / 2 -
                      1));
      }
    }

    double argumentsOffset = 0;
    final double xOffsetLimit = size.width - padding.right;
    double horizontalRatio;

    {
      Iterable<LabelEntry> labels;

      if (argumentsLabels == null) {
        throw "not implemented";
      } else {
        labels = argumentsLabels!;
        argumentsOffset = labels.first.value;

        if (!snapToLeftLabel) {
          argumentsOffset = arguments.first;
        }

        final double leftMost = snapToLeftLabel
            ? math.min(arguments.first, labels.first.value)
            : arguments.first;
        final double rightMost = snapToRightLabel
            ? math.max(arguments.last, labels.last.value)
            : arguments.last;
        final double noEmptySpaceRatio = width / (rightMost - leftMost);
        horizontalRatio = math.max(_minimalHorizontalRatio, noEmptySpaceRatio);
      }

      for (LabelEntry tuple in labels) {
        if (tuple.value < argumentsOffset) continue;
        final double xOffset =
            padding.left + (tuple.value - argumentsOffset) * horizontalRatio;
        if (xOffset > xOffsetLimit) break;

        if (verticalLinesPaint != null) {
          canvas.drawLine(
              Offset(xOffset, padding.top),
              Offset(xOffset, size.height - padding.bottom),
              verticalLinesPaint!);
        }

        final TextPainter textPainter = TextPainter(
            text: TextSpan(text: tuple.label, style: verticalLabelsTextStyle),
            textDirection: TextDirection.ltr)
          ..layout();
        textPainter.paint(
            canvas,
            Offset(xOffset - textPainter.width / 2,
                size.height - (verticalLabelsTextStyle?.fontSize ?? 12) - 8));
      }
    }

    Iterator<Iterable<double?>> series = values.iterator;
    Iterator<Paint?> linesPaints = seriesLinesPaints == null
        ? <Paint>[].iterator
        : (seriesLinesPaints ?? []).iterator;
    Iterator<Paint?> pointsPaints = seriesPointsPaints.iterator;
    while (series.moveNext()) {
      List<Offset> points = [];
      Iterator<double?> value = series.current.iterator;
      Iterator<double> argument = arguments.iterator;
      while (value.moveNext()) {
        argument.moveNext();
        if (value.current == null || value.current == double.nan) continue;

        if (argument.current < argumentsOffset) continue;
        final double xOffset = padding.left +
            (argument.current - argumentsOffset) * horizontalRatio;
        if (xOffset > xOffsetLimit) break;

        if (value.current! < valuesOffset) continue;
        final double yOffset = size.height -
            padding.bottom -
            (value.current! - valuesOffset) * verticalRatio;
        if (yOffset < padding.top) continue;

        points.add(Offset(xOffset, yOffset));
      }

      if (linesPaints.moveNext() && linesPaints.current != null) {
        canvas.drawPath(
            Path()..addPolygon(points, false), linesPaints.current!);
      }

      if (pointsPaints.moveNext() && pointsPaints.current != null) {
        canvas.drawPoints(ui.PointMode.points, points, pointsPaints.current!);
      }
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) => (arguments != old.arguments ||
          values != old.values ||
          argumentsLabels != old.argumentsLabels ||
          valuesLabels != old.valuesLabels ||
          seriesPointsPaints != old.seriesPointsPaints ||
          seriesLinesPaints != old.seriesLinesPaints ||
          horizontalLabelsTextStyle != old.horizontalLabelsTextStyle ||
          verticalLabelsTextStyle != old.verticalLabelsTextStyle ||
          padding != old.padding //
      );

  // ..., 0.01, 0.02, 0.05, 0.1, [0.125], 0.2, [0.25], 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, ...
  double _calculateOptimalStepValue(double valueRange, double height) {
    final int maxSteps = height ~/ minimalHorizontalLabelsInterval;
    if (maxSteps <= 0) {
      throw "invalid max lines!";
    }
    double interval = valueRange / maxSteps;
    if (interval > 1) {
      int zeros = 0;
      while (interval >= 10) {
        interval = interval / 10;
        zeros += 1;
      }
      /**/ if (interval <= 1) {
        interval = 1;
      } else if (interval <= 2) {
        interval = 2;
      } else if (interval <= 5) {
        interval = 5;
      }
      for (; zeros-- != 0;) {
        interval *= 10;
      }
    } else {
      // @TODO ! not working at all for lower :C
      int zeros = 0;
      while (interval < 0) {
        interval = interval * 10;
        zeros += 1;
      }
      /**/ if (interval <= 1) {
        interval = 1;
      } else if (interval <= 2) {
        interval = 2;
      } else if (interval <= 5) {
        interval = 5;
      }
      for (; zeros-- != 0;) {
        interval /= 10;
      }
    }
    return interval;
  }

  TextPainter _getLabelTextPainter(String text, TextStyle? style) {
    return TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout();
  }
}
