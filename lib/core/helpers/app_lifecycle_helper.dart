import 'dart:developer';
import 'package:flutter/widgets.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  static final AppLifecycleObserver _instance =
      AppLifecycleObserver._internal();
  bool _isForeground = true;
  AppLifecycleState _currentState = AppLifecycleState.resumed;

  factory AppLifecycleObserver() => _instance;
  AppLifecycleObserver._internal();

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  bool get isForeground => _isForeground;
  AppLifecycleState get currentState => _currentState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    _isForeground = state == AppLifecycleState.resumed;
    log('App is in foreground : $_isForeground');
  }
}
