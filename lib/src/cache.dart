part of mcache;

typedef OnDeleteCallback<T> = bool Function(T value);

/// Used for caching values.
class Cache {
  final Map<String, CachedValue> _values = {};

  /// All values keys.
  List<String> get keys => _values.keys.toList();

  Timer? _expirationTimer;

  bool _isDisposed = false;

  /// Displays whether this cache instance is disposed.
  bool get isDisposed => _isDisposed;

  Cache(
      {bool deleteOnExpire = true,
      Duration checkPeriod = const Duration(seconds: 600)}) {
    if (deleteOnExpire) {
      _expirationTimer = Timer.periodic(checkPeriod, (timer) {
        _checkExpiration();
      });
    }
  }

  void _checkExpiration() {
    var expired = _values.entries
        .where((element) =>
            element.value.expiration != null && element.value.isExpire())
        .toList();

    for (var i = 0; i < expired.length; i++) {
      var entry = expired[i];

      var onDelete = entry.value.onDelete;

      if (onDelete != null && onDelete(entry.value.value) ||
          entry.value.onDelete == null) {
        _values.remove(entry.key);
      } else {
        entry.value.cacheDate = DateTime.now();
      }
    }
  }

  /// Sets [value] by [key].
  void set(String key, dynamic value, {ExpirationSetting? expirationSetting}) {
    _values[key] = (CachedValue(value, expirationSetting?.expiration,
        expirationSetting?.onDelete, DateTime.now()));
  }

  /// If cache contains value by [key] updates it.
  ///
  /// Updates the lifetime of the value.
  void update(String key, dynamic value) {
    if (_values.containsKey(key)) {
      _values[key]!.value = value;
      _values[key]!.cacheDate = DateTime.now();
    }
  }

  /// Deletes value by [key].
  void delete(String key) {
    _values.remove(key);
  }

  /// Changes value expiration by [key].
  void changeExpiration(String key, ExpirationSetting expirationSetting) {
    var value = _values[key];

    if (value != null) {
      value.expiration = expirationSetting.expiration;

      value.onDelete = expirationSetting.onDelete;
    }
  }

  /// Checks is value by [key] has.
  bool has(String key) {
    return _values.containsKey(key);
  }

  /// Clears all values.
  void clear() {
    _values.clear();
  }

  /// Clears all values and cancel expiration timer.
  void dispose() {
    if (!_isDisposed) {
      _expirationTimer?.cancel();

      _expirationTimer = null;

      _values.clear();

      _isDisposed = true;
    }
  }

  /// Gets value by [key].
  dynamic get(String key) {
    var value = _values[key];

    if (value != null) {
      if (value.expiration != null && value.isExpire()) {
        delete(key);

        return null;
      } else {
        return value.value;
      }
    } else {
      return null;
    }
  }

  dynamic operator [](String key) {
    return get(key);
  }
}
