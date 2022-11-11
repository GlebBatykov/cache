import 'package:mcache/mcache.dart';

void main(List<String> args) {
  var cache = Cache(checkPeriod: const Duration(milliseconds: 250));

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(seconds: 1)));

  Future.delayed(const Duration(milliseconds: 500), () {
    cache.update('name', 'Tom');
  });

  Future.delayed(const Duration(milliseconds: 1300), () {
    print(cache['name']);
  });

  Future.delayed(const Duration(milliseconds: 1600), () {
    print(cache['name']);

    cache.dispose();
  });
}
