part of cache;

class CachedValue {
  final dynamic value;

  Duration? expiration;

  final DeleteCallback? onDelete;

  DateTime cacheDate;

  CachedValue(this.value, this.expiration, this.onDelete, this.cacheDate);

  bool isExpire() {
    return cacheDate.add(expiration!).isBefore(DateTime.now());
  }
}
