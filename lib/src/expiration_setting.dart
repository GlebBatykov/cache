part of cache;

class ExpirationSetting {
  final Duration? expiration;

  final DeleteCallback? onDelete;

  ExpirationSetting({this.expiration, this.onDelete});
}
