import 'package:cache/cache.dart';

void main() {
  var cache = Cache(checkPeriod: Duration(milliseconds: 500));

  cache.set('name', 'Gleb');

  print(cache['name']);

  cache.set('123', 123,
      expirationSetting: ExpirationSetting(
          expiration: Duration(seconds: 2),
          onDelete: (value) {
            print(value);

            return false;
          }));
}
