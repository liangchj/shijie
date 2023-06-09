/// 时间转换为分秒(分:秒)
String durationToMinuteAndSecond(Duration duration) {
  int seconds = duration.inSeconds;
  return secondToMinuteAndSecond(seconds);
}

/// 秒数转换为分秒(分:秒)
String secondToMinuteAndSecond(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  return "${m < 10 ? '0' : ''}$m:${s < 10 ? '0' : ''}$s";
}