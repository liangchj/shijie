import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
/// 模仿audio_video_progress_bar和官方slider实现的进度条（仅保留进度条）
class PlayerProgressBar extends LeafRenderObjectWidget {
  const PlayerProgressBar(
      {Key? key,
        required this.progress,
        required this.totalDuration,
        this.bufferedDurationRange = BufferedDurationRange.empty,
        this.barHeight = 4.0,
        this.barCapShape = BarCapShape.round,
        this.baseBarColor,
        this.progressBarColor,
        this.bufferedBarColor,
        this.thumbShape,
        this.thumbColor,
        this.thumbOverlayShape,
        this.thumbOverlayColor,
        this.onChangeStart,
        required this.onChanged,
        this.onChangeEnd,
        this.onSeek})
      : super(key: key);

  /// 当前进度
  final Duration progress;

  /// 总时长
  final Duration totalDuration;

  /// 缓冲时长
  final List<BufferedDurationRange> bufferedDurationRange;

  /// 进度条高度
  final double barHeight;

  /// 进度条圆角情况
  final BarCapShape barCapShape;

  /// 进度条基本颜色（背景颜色）
  /// 默认取主题颜色0.24透明度
  final Color? baseBarColor;

  /// 当前进度颜色
  /// /// 默认取主题颜色
  final Color? progressBarColor;

  /// 缓冲演示
  /// /// 默认取主题颜色0.5透明度
  final Color? bufferedBarColor;

  /// 滑块形状
  final ProgressBarThumbComponentShape? thumbShape;

  ///
  ///final double thumbRadius;
  /// 滑块颜色
  /// 默认取当前进度颜色，如没有设置则取主题颜色
  final Color? thumbColor;

  /// 按压时滑块外圈形状
  final ProgressBarThumbComponentShape? thumbOverlayShape;

  ///final double thumbOverlayRadius;
  /// 按压时滑块外圈颜色
  /// 没有设置时，取(滑块颜色 ?? 当前进度颜色 ?? 主题颜色)0.12透明度
  /// 自定义设置形状后失效
  final Color? thumbOverlayColor;

  /// 滑块开始改变时回掉函数
  final ValueChanged<DragStartDetails>? onChangeStart;

  /// 滑块改变时回掉函数
  final ValueChanged<DragUpdateDetails> onChanged;

  /// 滑块改变结束后回掉函数
  final ValueChanged<ThumbChangedResult>? onChangeEnd;

  /// 进行进度跳转回掉函数
  final ValueChanged<ThumbChangedResult>? onSeek;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    Color defaultBaseBarColor = baseBarColor ?? primaryColor.withOpacity(0.24);
    Color defaultProgressBarColor = progressBarColor ?? primaryColor;
    Color defaultBufferedBarColor =
        bufferedBarColor ?? primaryColor.withOpacity(0.5);
    Color defaultThumbColor = thumbColor ?? progressBarColor ?? primaryColor;
    Color defaultThumbOverlayColor = thumbOverlayColor ??
        (thumbColor ?? progressBarColor ?? primaryColor).withOpacity(0.12);

    /// 滑块形状

    return _RenderProgressBarBox(
      progress: progress,
      totalDuration: totalDuration,
      bufferedDurationRange: bufferedDurationRange,
      barHeight: barHeight,
      barCapShape: barCapShape,
      baseBarColor: defaultBaseBarColor,
      progressBarColor: defaultProgressBarColor,
      bufferedBarColor: defaultBufferedBarColor,
      thumbShape: thumbShape ??
          ProgressBarThumbShape(
              thumbRadius: barHeight,
              thumbColor: thumbColor ?? defaultThumbColor),
      thumbOverlayShape: thumbOverlayShape ??
          ProgressBarThumbOverlayShape(
              thumbOverlayRadius: thumbShape?.getPreferredSize().width ?? barHeight * 4,
              thumbOverlayColor:
              thumbOverlayColor ?? defaultThumbOverlayColor),
      onChangeStart: onChangeStart,
      onChanged: onChanged,
      onChangeEnd: onChangeEnd,
      onSeek: onSeek,
      platform: Theme.of(context).platform,
    );
  }

  @override
  Future<void> updateRenderObject(
      BuildContext context, covariant _RenderProgressBarBox renderObject) async {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    Color defaultBaseBarColor = baseBarColor ?? primaryColor.withOpacity(0.24);
    Color defaultProgressBarColor = progressBarColor ?? primaryColor;
    Color defaultBufferedBarColor =
        bufferedBarColor ?? primaryColor.withOpacity(0.5);
    Color defaultThumbColor = thumbColor ?? progressBarColor ?? primaryColor;
    Color defaultThumbOverlayColor = thumbOverlayColor ??
        (thumbColor ?? progressBarColor ?? primaryColor).withOpacity(0.12);
    renderObject
      ..progress = progress
      ..totalDuration = totalDuration
      ..bufferedDurationRange = bufferedDurationRange
      ..barHeight = barHeight
      ..barCapShape = barCapShape
      ..baseBarColor = defaultBaseBarColor
      ..progressBarColor = defaultProgressBarColor
      ..bufferedBarColor = defaultBufferedBarColor
      ..thumbShape = thumbShape ?? ProgressBarThumbShape(
          thumbRadius: barHeight, thumbColor: thumbColor ?? defaultThumbColor)
      ..thumbOverlayShape = thumbOverlayShape ?? ProgressBarThumbOverlayShape(
          thumbOverlayRadius: 8.0,
          thumbOverlayColor: thumbOverlayColor ?? defaultThumbOverlayColor)
      ..onSeek = onSeek
      ..onChangeStart = onChangeStart
      ..onChanged = onChanged
      ..onChangeEnd = onChangeEnd
      ..platform = Theme.of(context).platform;
  }
}

class _RenderProgressBarBox extends RenderBox {
  _RenderProgressBarBox({
    required Duration progress,
    required Duration totalDuration,
    required List<BufferedDurationRange> bufferedDurationRange,
    required double barHeight,
    required Color baseBarColor,
    required Color progressBarColor,
    required Color bufferedBarColor,
    required ProgressBarThumbComponentShape thumbShape,
    required ProgressBarThumbComponentShape thumbOverlayShape,
    required BarCapShape barCapShape,
    ValueChanged<DragStartDetails>? onChangeStart,
    required ValueChanged<DragUpdateDetails> onChanged,
    ValueChanged<ThumbChangedResult>? onChangeEnd,
    ValueChanged<ThumbChangedResult>? onSeek,
    required TargetPlatform platform,
  })  : _platform = platform,
        _progress = progress,
        _totalDuration = totalDuration,
        _bufferedDurationRange = bufferedDurationRange,
        _barHeight = barHeight,
        _barCapShape = barCapShape,
        _baseBarColor = baseBarColor,
        _progressBarColor = progressBarColor,
        _bufferedBarColor = bufferedBarColor,
        _thumbShape = thumbShape,
        _thumbOverlayShape = thumbOverlayShape,
        _onChangeStart = onChangeStart,
        _onChanged = onChanged,
        _onChangeEnd = onChangeEnd,
        _onSeek = onSeek {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..onCancel = _finishDrag;
    _thumbValue = _proportionOfTotal(_progress);
  }

  TargetPlatform _platform;
  TargetPlatform get platform => _platform;
  set platform(TargetPlatform value) {
    if (_platform == value) return;
    _platform = value;
    markNeedsSemanticsUpdate();
  }

  /// 当前进度
  Duration _progress;
  Duration get progress => _progress;
  set progress(Duration newValue) {
    if (_progress == newValue) {
      return;
    }
    _progress = newValue;
    if (!_userIsDrag) {
      _thumbValue = _proportionOfTotal(newValue);
    }
    markNeedsPaint();
  }

  /// 总时长
  Duration _totalDuration;
  Duration get totalDuration => _totalDuration;
  set totalDuration(Duration newValue) {
    if (_totalDuration == newValue) {
      return;
    }
    _totalDuration = newValue;
    if (!_userIsDrag) {
      _thumbValue = _proportionOfTotal(progress);
    }
    markNeedsPaint();
  }

  /// 缓冲时长
  List<BufferedDurationRange> _bufferedDurationRange;
  List<BufferedDurationRange> get bufferedDurationRange => _bufferedDurationRange;
  set bufferedDurationRange(List<BufferedDurationRange> newValue) {
    if (_bufferedDurationRange == newValue) {
      return;
    }
    _bufferedDurationRange = newValue;
    markNeedsPaint();
  }
  /*Duration _buffered;
  Duration get buffered => _buffered;
  set buffered(Duration newValue) {
    if (_buffered == newValue) {
      return;
    }
    _buffered = newValue;
    markNeedsPaint();
  }*/

  /// 进度条高度
  double _barHeight;
  double get barHeight => _barHeight;
  set barHeight(double newValue) {
    if (_barHeight == newValue) {
      return;
    }
    _barHeight = newValue;
    //markNeedsPaint();
    markNeedsLayout();
  }

  /// 进度条圆角情况
  BarCapShape _barCapShape;
  BarCapShape get barCapShape => _barCapShape;
  set barCapShape(BarCapShape newValue) {
    if (_barCapShape == newValue) {
      return;
    }
    _barCapShape = newValue;
    markNeedsPaint();
  }

  /// 进度条基本颜色（背景颜色）
  Color _baseBarColor;
  Color get baseBarColor => _baseBarColor;
  set baseBarColor(Color newValue) {
    if (_baseBarColor == newValue) {
      return;
    }
    _baseBarColor = newValue;
    markNeedsPaint();
  }

  /// 当前进度颜色
  Color _progressBarColor;
  Color get progressBarColor => _progressBarColor;
  set progressBarColor(Color newValue) {
    if (_progressBarColor == newValue) {
      return;
    }
    _progressBarColor = newValue;
    markNeedsPaint();
  }

  /// 当前缓冲颜色
  Color _bufferedBarColor;
  Color get bufferedBarColor => _bufferedBarColor;
  set bufferedBarColor(Color newValue) {
    if (_bufferedBarColor == newValue) {
      return;
    }
    _bufferedBarColor = newValue;
    markNeedsPaint();
  }

  /// 滑块形状
  ProgressBarThumbComponentShape _thumbShape;
  ProgressBarThumbComponentShape get thumbShape => _thumbShape;
  set thumbShape(ProgressBarThumbComponentShape newValue) {
    Map<String, Color?> colorMap = _thumbShape.getThumbColorMap();
    Map<String, Color?> newColorMap = newValue.getThumbColorMap();
    bool colorChange = false;
    colorMap.forEach((key, value) {
      if (newColorMap[key] != value) {
        colorChange = true;
      }
    });
    if (_thumbShape == newValue && !colorChange) {
      return;
    }
    _thumbShape = newValue;
    if (_thumbShape.getPreferredSize() != newValue.getPreferredSize()) {
      markNeedsLayout();
    } else {
      markNeedsPaint();
    }
  }

  /// 按压时滑块外圈形状
  ProgressBarThumbComponentShape _thumbOverlayShape;
  ProgressBarThumbComponentShape get thumbOverlayShape => _thumbOverlayShape;
  set thumbOverlayShape(ProgressBarThumbComponentShape newValue) {
    Map<String, Color?> colorMap = _thumbOverlayShape.getThumbColorMap();
    Map<String, Color?> newColorMap = newValue.getThumbColorMap();
    bool colorChange = false;
    colorMap.forEach((key, value) {
      if (newColorMap[key] != value) {
        colorChange = true;
      }
    });
    if (_thumbOverlayShape == newValue && !colorChange) {
      return;
    }
    _thumbOverlayShape = newValue;
    if (_thumbOverlayShape.getPreferredSize() != newValue.getPreferredSize()) {
      markNeedsLayout();
    } else {
      if (_userIsDrag) {
        markNeedsPaint();
      }
    }
  }


  ValueChanged<DragStartDetails>? _onChangeStart;
  ValueChanged<DragStartDetails>? get onChangeStart => _onChangeStart;
  set onChangeStart(ValueChanged<DragStartDetails>? newValue) {
    if (_onChangeStart == newValue) {
      return;
    }
    _onChangeStart = newValue;
  }

  ValueChanged<DragUpdateDetails> _onChanged;
  ValueChanged<DragUpdateDetails> get onChanged => _onChanged;
  set onChanged(ValueChanged<DragUpdateDetails> newValue) {
    if (_onChanged == newValue) {
      return;
    }
    _onChanged = newValue;
  }

  ValueChanged<ThumbChangedResult>? _onChangeEnd;
  ValueChanged<ThumbChangedResult>? get onChangeEnd => _onChangeEnd;
  set onChangeEnd(ValueChanged<ThumbChangedResult>? newValue) {
    if (_onChangeEnd == newValue) {
      return;
    }
    _onChangeEnd = newValue;
  }

  ValueChanged<ThumbChangedResult>? _onSeek;
  ValueChanged<ThumbChangedResult>? get onSeek => _onSeek;
  set onSeek(ValueChanged<ThumbChangedResult>? newValue) {
    if (newValue == _onSeek) {
      return;
    }
    _onSeek = newValue;
  }

  /// 这是用来移动滑块的手势识别。
  HorizontalDragGestureRecognizer? _drag;

  /// 滑块占进度条比例
  late double _thumbValue;

  /// 标记用户是否在滑动
  bool _userIsDrag = false;

  /// 开始拖动时的时间区间
  Duration? _userDragStartDuration;
  Duration? get userDragStartDuration => _userDragStartDuration;


  /// 获取指定时间占比（指定时间 / 总时间）
  double _proportionOfTotal(Duration duration) {
    if (_totalDuration.inMilliseconds == 0) {
      return 0.0;
    }
    return duration.inMilliseconds / _totalDuration.inMilliseconds;
  }

  /// 开始滑动
  void _handleDragStart(DragStartDetails details) {
    _userIsDrag = true; // 标记抓取滑动
    _userDragStartDuration = _currentThumbDuration();

    /// 更新滑块位置
    _updateThumbPosition(details.localPosition);

    /// 回掉函数
    _onChangeStart?.call(details);
  }

  /// 滑动更新
  void _handleDragUpdate(DragUpdateDetails details) {
    /// 更新滑块位置
    _updateThumbPosition(details.localPosition);

    /// 回掉函数
    _onChanged.call(details);
  }

  /// 滑动结束
  void _handleDragEnd(DragEndDetails details) {
    Duration currentThumbDuration = _currentThumbDuration();
    // 计算滑动差值
    int millisecondDifference = currentThumbDuration.inMilliseconds.toInt() -
        (userDragStartDuration ?? Duration.zero).inMilliseconds.toInt();

    /// 回掉函数（返回当前滑块位置时间）
    _onChangeEnd?.call(ThumbChangedResult(
      currentDuration: currentThumbDuration,
      prevDuration: Duration.zero,
      millisecondDifference: millisecondDifference,
    ));

    /// 可以进行进度跳转回掉函数（返回当前滑块位置时间）
    _onSeek?.call(ThumbChangedResult(
      currentDuration: currentThumbDuration,
      prevDuration: Duration.zero,
      millisecondDifference: millisecondDifference,
    ));
    _finishDrag();
  }

  /// 结束滑动
  void _finishDrag() {
    /// 取消标记抓取滑动
    _userIsDrag = false;
    markNeedsPaint();
  }

  /// 获取当前滑块时间区间
  Duration _currentThumbDuration() {
    /// 当前滑块在进度条上的时间区（毫秒）
    final thumbMilliseconds = _thumbValue * totalDuration.inMilliseconds;
    return Duration(milliseconds: thumbMilliseconds.round());
  }

  /// 更新滑块位置
  void _updateThumbPosition(Offset localPosition) {
    final dx = localPosition.dx;

    /// 进度条圆角
    final barCapRadius = _barHeight / 2;

    /// 进度条起始位置
    double barStart = barCapRadius;

    /// 进度条结束位置
    double barEnd = size.width - barCapRadius;

    /// 进度条总长度（px）
    final barWidth = barEnd - barStart;

    /// 滑块相对于进度条位置
    final position = (dx - barStart).clamp(0.0, barWidth);

    /// 滑块占进度条比例
    _thumbValue = (position / barWidth);
    markNeedsPaint();
  }

  /// 获取滑块最大宽度
  double get _maxThumbWidth =>
      _thumbSizes.map((Size size) => size.width).reduce(math.max);

  /// 获取滑块最大高度
  double get _maxThumbHeight =>
      _thumbSizes.map((Size size) => size.height).reduce(math.max);
  List<Size> get _thumbSizes => <Size>[
    thumbOverlayShape.getPreferredSize(),
    thumbShape.getPreferredSize(),
  ];

  /// 滑块宽
  double get _thumbWidth => thumbShape.getPreferredSize().width;

  /// 滑块高
  double get _thumbHeight => thumbShape.getPreferredSize().height;

  /// 计算整个进度条的高度
  double _calculateDesiredHeight() {
    return max(_thumbHeight, _barHeight);
  }

  static const double _minBarWidth = 100.0;

  @override
  double computeMinIntrinsicWidth(double height) =>
      _minBarWidth + _maxThumbWidth;

  @override
  double computeMaxIntrinsicWidth(double height) =>
      _minBarWidth + _maxThumbWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _calculateDesiredHeight();

  @override
  double computeMaxIntrinsicHeight(double width) => _calculateDesiredHeight();

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  /// 计算绘制整个进度条的Size
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = _calculateDesiredHeight();
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag?.addPointer(event);
    }
  }

  @override
  bool get isRepaintBoundary => true;


  /// 开始绘制
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    _drawProgressBarWithoutLabels(canvas);
  }


  /// 绘制进度条（仅有进度条和滑块的情况）
  void _drawProgressBarWithoutLabels(Canvas canvas) {
    final barWidth = size.width;
    final barHeight = _calculateDesiredHeight();
    _drawProgressBar(canvas, Offset.zero, Size(barWidth, barHeight));
  }

  /// 开始绘制进度条
  void _drawProgressBar(Canvas canvas, Offset offset, Size localSize) {
    canvas.save();
    //canvas.translate(offset.dx, offset.dy);
    double width = localSize.width - max(_thumbWidth, _barHeight);
    double startDx = offset.dx + max(_thumbWidth / 2, _barHeight / 2);
    double height = localSize.height;
    double endDx = startDx + width;
    double topDy = offset.dy + (height / 2) - (_barHeight / 2);
    double bottomDy = offset.dy + (height / 2) + (_barHeight / 2);

    /// 进度条两边角度情况（圆角或者直角）
    /// 圆角半径
    final Radius barRadius = Radius.circular(_barHeight);

    /// 绘制基本部分（进度条背景）
    RRect baseBarRRect = RRect.fromLTRBAndCorners(
        startDx, topDy, endDx, bottomDy,
        topLeft: barRadius,
        bottomLeft: barRadius,
        topRight: barRadius,
        bottomRight: barRadius);

    /// 播放或缓冲没有占满才需要绘制
    canvas.drawRRect(baseBarRRect, Paint()..color = baseBarColor);

    /// 进度长度
    double progressProportion = _proportionOfTotal(_progress);
    double progressLen =
    progressProportion >= 1 ? width : progressProportion * width;

    /// 缓冲长度（X轴结束点）
    if (_bufferedDurationRange.isNotEmpty) {
      for (var element in _bufferedDurationRange) {
        var start = element.start;
        var end = element.end;
        var xStart = _proportionOfTotal(start) * width;
        var xEnd = _proportionOfTotal(end) * width;
        xStart = startDx + xStart > endDx ? endDx : startDx + xStart;
        xEnd = startDx + xEnd > endDx ? endDx : startDx + xEnd;
        RRect bufferedBarRRect = RRect.fromLTRBAndCorners(
            xStart, topDy, xEnd, bottomDy,
            topLeft: barRadius,
            bottomLeft: barRadius,
            topRight: barRadius,
            bottomRight: barRadius);

        /// 绘制缓冲部分
        canvas.drawRRect(bufferedBarRRect, Paint()..color = bufferedBarColor);
      }
    }
    /// 绘制进度部分
    /// 有进度才需要绘制
    if (progressProportion > 0) {
      RRect progressBarRRect = RRect.fromLTRBAndCorners(
          startDx, topDy, startDx + progressLen, bottomDy,
          topLeft: barRadius,
          bottomLeft: barRadius,
          topRight: barRadius,
          bottomRight: barRadius);
      canvas.drawRRect(progressBarRRect, Paint()..color = progressBarColor);
    }

    /// 滑块X轴坐标
    var thumbLen = _thumbValue * width;

    Offset thumbCenter =
    Offset(thumbLen + startDx, topDy + ((bottomDy - topDy) / 2));
    if (_userIsDrag) {
      thumbOverlayShape.paint(canvas, thumbCenter);
    }
    thumbShape.paint(canvas, thumbCenter);
    canvas.restore();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    // description
    config.textDirection = TextDirection.ltr;
    config.label = 'Progress bar';
    config.value = '${(_thumbValue * 100).round()}%';

    // increase action
    config.onIncrease = increaseAction;
    final increased = _thumbValue + _adjustmentUnit;
    config.increasedValue = '${((increased).clamp(0.0, 1.0) * 100).round()}%';

    // descrease action
    config.onDecrease = decreaseAction;
    final decreased = _thumbValue - _adjustmentUnit;
    config.decreasedValue = '${((decreased).clamp(0.0, 1.0) * 100).round()}%';
  }

  double get _adjustmentUnit {
    switch (_platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      // Matches iOS implementation of material slider.
        return 0.1;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      // Matches Android implementation of material slider.
        return 0.05;
    }
  }

  void increaseAction() {
    final newValue = _thumbValue + _adjustmentUnit;
    _thumbValue = (newValue).clamp(0.0, 1.0);
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  void decreaseAction() {
    final newValue = _thumbValue - _adjustmentUnit;
    _thumbValue = (newValue).clamp(0.0, 1.0);
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }
}

/// 按压时滑块外圈形状
class ProgressBarThumbOverlayShape extends ProgressBarThumbComponentShape {
  ProgressBarThumbOverlayShape({
    this.thumbOverlayRadius,
    this.thumbOverlayColor,
  });
  final double? thumbOverlayRadius;

  final Color? thumbOverlayColor;
  @override
  Size getPreferredSize() {
    return Size.fromRadius(thumbOverlayRadius ?? 0);
  }

  @override
  void paint(Canvas canvas, Offset center) {
    if ((thumbOverlayRadius ?? 0) > 0 && thumbOverlayColor != null) {
      canvas.drawCircle(
        center,
        thumbOverlayRadius!,
        Paint()..color = thumbOverlayColor!,
      );
    }
  }

  @override
  Map<String, Color?> getThumbColorMap() {
    return {"thumbOverlayColor": thumbOverlayColor};
  }
}

/// 进度条滑块形状
class ProgressBarThumbShape extends ProgressBarThumbComponentShape {
  ProgressBarThumbShape({
    this.thumbRadius = 4.0,
    required this.thumbColor,
    this.thumbInnerRadius,
    this.thumbInnerColor,
  });

  /// 滑块半径
  /// 默认4.0，若传过来的是小于等于0的就不绘制
  final double thumbRadius;

  /// 滑块颜色
  final Color thumbColor;

  /// 滑块内圈半径
  final double? thumbInnerRadius;

  ///滑块颜色
  /// 不指定颜色且外圈[thumbColor]也不指定颜色时不绘制
  final Color? thumbInnerColor;

  @override
  Size getPreferredSize() {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(Canvas canvas, Offset center) {
    /// 滑块半径大于0的才绘制
    if (thumbRadius > 0) {
      canvas.drawCircle(center, thumbRadius, Paint()..color = thumbColor);
    }

    /// 绘制内圈
    if ((thumbInnerRadius ?? 0) > 0 && thumbInnerColor != null) {
      canvas.drawCircle(
          center, thumbInnerRadius!, Paint()..color = thumbInnerColor!);
    }
  }

  @override
  Map<String, Color?> getThumbColorMap() {
    return {"thumbColor": thumbColor, "thumbInnerColor": thumbInnerColor};
  }
}

abstract class ProgressBarThumbComponentShape {
  const ProgressBarThumbComponentShape();
  Size getPreferredSize();
  Map<String, Color?> getThumbColorMap();
  void paint(Canvas canvas, Offset center);
}

enum BarCapShape {
  /// The left and right ends of the bar are round.
  round,

  /// The left and right ends of the bar are square.
  square,
}

/// 滑块滑动结束后结果信息
class ThumbChangedResult {
  ThumbChangedResult({
    this.currentDuration = Duration.zero,
    this.prevDuration = Duration.zero,
    this.millisecondDifference = 0,
  });

  /// 当前时间区间
  final Duration currentDuration;

  /// 滑动前的时间区间
  final Duration prevDuration;

  /// 滑动差值（毫秒）
  final int millisecondDifference;
}
/// 缓冲区间
class BufferedDurationRange {
  BufferedDurationRange({required this.start, required this.end});
  /// 开始时间
  final Duration start;

  /// 结束时间
  final Duration end;

  static const List<BufferedDurationRange> empty = <BufferedDurationRange>[];
}