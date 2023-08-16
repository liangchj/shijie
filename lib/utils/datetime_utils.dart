import 'package:intl/intl.dart';

abstract class DateTimeUtils {
  static String ymdhms = "yyyy-MM-dd HH:mm:ss";
  static String ymdhm = "yyyy-MM-dd HH:mm";
  static String ymdh = "yyyy-MM-dd HH";
  static String ymd = "yyyy-MM-dd";
  static String ym = "yyyy-MM";
  static String hms = "HH:mm:ss";
  static String hm = "HH:mm";

  static DateFormat ymdhmsFormatter = DateFormat(ymdhms);
  static DateFormat ymdhmFormatter = DateFormat(ymdhm);
  static DateFormat ymdhFormatter = DateFormat(ymdh);
  static DateFormat ymdFormatter = DateFormat(ymd);
  static DateFormat ymFormatter = DateFormat(ym);
  static DateFormat hmsFormatter = DateFormat(hms);
  static DateFormat hmFormatter = DateFormat(hm);
}