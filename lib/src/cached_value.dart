part of cache;

class CachedValue {
  final dynamic value;

  Duration? expiration;

  final DateTime cacheDate;

  CachedValue(this.value, this.expiration, this.cacheDate);

  bool isExpire() {
    return cacheDate.add(expiration!).isBefore(DateTime.now());
  }
}
