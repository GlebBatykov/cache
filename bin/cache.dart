import 'package:cache/cache.dart';

void main() {
  var cache = Cache(checkPeriod: Duration(milliseconds: 100));

  cache.set('1', 123);

  cache.set('2', 2, expiration: Duration(seconds: 1));

  cache.set('3', 3, expiration: Duration(microseconds: 100));

  Future.delayed(Duration(seconds: 2), () {
    print(cache['1']);

    print(cache['2']);

    print(cache['3']);

    cache.dispose();
  });
}
