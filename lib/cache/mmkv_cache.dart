
import 'dart:convert';

import 'package:mmkv/mmkv.dart';

/// 等待MMKV初始化
class MMKVCacheInit {
  static bool initialize = false;

  MMKVCacheInit._() {
    init();
  }

  MMKVCacheInit._setInitialize(bool flag) {
    initialize = flag;
  }

  static Future<bool> preInit() async {
    if (!initialize) {
      var initialize = await MMKV.initialize();
      MMKVCacheInit._setInitialize(true);
    }
    return initialize;
  }

  Future<void> init() async {
    var initialize = await MMKV.initialize();
  }
}
abstract class MMKVCacheBase {
  setString(String key, String value);

  setBool(String key, bool value);

  setInt(String key, int value);

  setDouble(String key, double value);

  setInt32(String key, int value);
  setBytes(String key, MMBuffer value);

  setIntList(String key, List<int> list);

  get<T>(String key, MMKVType type);
  bool getBool(String key);
  String? getString(String key);
  double getDouble(String key);
  int getInt(String key);
  int getInt32(String key);
  MMBuffer? getBytes(String key);
  String? getBytesConvert(String key);
  removeKey(String key);
  removeKeyList(List<String> keyList);
}

class MMKVCache extends MMKVCacheBase {
  final MMKV _mmkv;
  MMKVCache(this._mmkv) {
    MMKVCacheInit.preInit();
  }

  @override
  get<T>(String key, MMKVType type) {
    dynamic value;
    switch (type) {
      case MMKVType.string:
        value = _mmkv.decodeString(key);
        break;
      case MMKVType.bool:
        value = _mmkv.decodeBool(key);
        break;
      case MMKVType.int:
        value = _mmkv.decodeInt(key);
        break;
      case MMKVType.int32:
        value = _mmkv.decodeInt32(key);
        break;
      case MMKVType.double:
        value = _mmkv.decodeDouble(key);
        break;
      case MMKVType.bytes:
        value = _mmkv.decodeBytes(key);
        break;
      case MMKVType.bytesConvert:
        var bytes = _mmkv.decodeBytes(key);
        if (bytes != null) {
          value = const Utf8Decoder().convert(bytes.asList()!);
        }
        break;
      default:
        break;
    }
    return value;
  }

  @override
  bool getBool(String key) {
    return _mmkv.decodeBool(key);
  }

  @override
  MMBuffer? getBytes(String key) {
    return _mmkv.decodeBytes(key);
  }

  @override
  String? getBytesConvert(String key) {
    MMBuffer? bytes = _mmkv.decodeBytes(key);
    if (bytes == null) {
      return null;
    }
    return const Utf8Decoder().convert(bytes.asList()!);
  }

  @override
  double getDouble(String key) {
    return _mmkv.decodeDouble(key);
  }

  @override
  int getInt(String key) {
    return _mmkv.decodeInt(key);
  }

  @override
  int getInt32(String key) {
    return _mmkv.decodeInt32(key);
  }

  @override
  String? getString(String key) {
    return _mmkv.decodeString(key);
  }

  @override
  setBool(String key, bool value) {
    return _mmkv.decodeBool(key);
  }

  @override
  setBytes(String key, MMBuffer value) {
    return _mmkv.decodeBytes(key);
  }

  @override
  setDouble(String key, double value) {
    return _mmkv.decodeDouble(key);
  }

  @override
  setInt(String key, int value) {
    _mmkv.encodeInt(key, value);
  }

  @override
  setInt32(String key, int value) {
    _mmkv.encodeInt32(key, value);
  }

  @override
  setIntList(String key, List<int> list) {
    var bytes = MMBuffer.fromList(list);
    _mmkv.encodeBytes(key, bytes);
  }

  @override
  setString(String key, String value) {
    _mmkv.encodeString(key, value);
  }

  @override
  removeKey(String key) {
    _mmkv.removeValue(key);
  }

  @override
  removeKeyList(List<String> keyList) {
    _mmkv.removeValues(keyList);
  }
}
/// 默认的MMKV
class DefaultMMKVCache extends MMKVCache  {

  DefaultMMKVCache._() : super(MMKV.defaultMMKV());
  static final DefaultMMKVCache _instance = DefaultMMKVCache._();

  static MMKVCache getInstance() {
    return _instance;
  }
}
/// 播放列表MMKV
class PlayListMMKVCache extends MMKVCache  {
  PlayListMMKVCache._() : super(MMKV(MMKVMapID.playList.mmapID));
  static final PlayListMMKVCache _instance = PlayListMMKVCache._();
  static MMKVCache getInstance() {
    return _instance;
  }
}
/// 播放历史MMKV
class PlayHistoryMMKVCache extends MMKVCache  {
  PlayHistoryMMKVCache._() : super(MMKV(MMKVMapID.playHistory.mmapID));
  static final PlayHistoryMMKVCache _instance = PlayHistoryMMKVCache._();
  static MMKVCache getInstance() {
    return _instance;
  }
}
/// 弹幕MMKV
class DanmakuMMKVCache extends MMKVCache  {
  DanmakuMMKVCache._() : super(MMKV(MMKVMapID.danmaku.mmapID));
  static final DanmakuMMKVCache _instance = DanmakuMMKVCache._();
  static MMKVCache getInstance() {
    return _instance;
  }
}
/// 字幕MMKV
class SubtitleMMKVCache extends MMKVCache  {
  SubtitleMMKVCache._() : super(MMKV(MMKVMapID.subtitle.mmapID));
  static final SubtitleMMKVCache _instance = SubtitleMMKVCache._();
  static MMKVCache getInstance() {
    return _instance;
  }
}

enum MMKVMapID {
  playList("playList"),
  danmaku("danmaku"),
  subtitle("subtitle"),
  playHistory("playHistory");
  final String mmapID;
  const MMKVMapID(this.mmapID);
}

enum MMKVType { int, int32, double, string, bool, bytes, bytesConvert, intList }