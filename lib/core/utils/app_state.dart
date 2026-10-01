import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../../data/models/passage_reference.dart';

class AppState extends ChangeNotifier {
  PassageReference? _lastReadingLocation;
  double _textSize = 16.0;
  bool _isDarkMode = false;
  bool _isFirstLaunch = true;

  PassageReference? get lastReadingLocation => _lastReadingLocation;
  double get textSize => _textSize;
  bool get isDarkMode => _isDarkMode;
  bool get isFirstLaunch => _isFirstLaunch;

  void setLastReadingLocation(PassageReference location) {
    _lastReadingLocation = location;
    notifyListeners();
  }

  void setTextSize(double size) {
    _textSize = size.clamp(12.0, 24.0);
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setFirstLaunchComplete() {
    _isFirstLaunch = false;
    notifyListeners();
  }
}
