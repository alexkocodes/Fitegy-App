import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _firstTime = prefs.getBool('ff_firstTime') ?? _firstTime;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isChallengePrivate = false;
  bool get isChallengePrivate => _isChallengePrivate;
  set isChallengePrivate(bool _value) {
    _isChallengePrivate = _value;
  }

  bool _firstTime = true;
  bool get firstTime => _firstTime;
  set firstTime(bool _value) {
    _firstTime = _value;
    prefs.setBool('ff_firstTime', _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
