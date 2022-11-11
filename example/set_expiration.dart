import 'package:mcache/mcache.dart';

void main(List<String> args) {
  var cache = Cache(checkPeriod: const Duration(seconds: 1));

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(seconds: 3)));

  cache.set('key', '1o23fjadijs',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(seconds: 3)));

  print(cache['name']);

  print(cache['key']);

  Future.delayed(const Duration(seconds: 4), () {
    print(cache['name']);

    print(cache['key']);

    cache.dispose();
  });
}
