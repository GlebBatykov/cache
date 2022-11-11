part of cache;

/// Contains the expiration settings.
class ExpirationSetting {
  /// Expiration time.
  final Duration? expiration;

  /// The callback that is called when the value is deleted, when the time expires.
  ///
  /// If it returns true, the value will be deleted.
  ///
  /// If it returns false, the value will not be deleted, its lifetime will be updated.
  final OnDeleteCallback? onDelete;

  ExpirationSetting({this.expiration, this.onDelete});
}
