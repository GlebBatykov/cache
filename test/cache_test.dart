import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('cache', () {
    late Cache cache;

    setUp(() {
      cache = Cache(checkPeriod: Duration(milliseconds: 100));
    });

    tearDown(() {
      cache.dispose();
    });

    test('set', () {
      cache.set('123', 'test');

      cache.set('hello', 234932);

      expect(cache.get('hello'), 234932);

      expect(cache.get('123'), 'test');
    });

    test('get', () {
      cache.set('123', 'test');

      expect(cache.get('123'), 'test');
    });

    test('delete', () {
      cache.set('123', 'test');

      cache.delete('123');

      expect(cache.get('123'), null);
    });

    test('dispose', () {
      cache.set('123', 'test');

      cache.dispose();

      expect(cache.get('123'), null);

      expect(cache.isDisposed, true);
    });

    test('has', () {
      cache.set('123', 'test');

      expect(cache.has('123'), true);
    });

    test('change expiration', () async {
      cache.set('123', 123, expiration: Duration(milliseconds: 100));

      cache.changeExpiration('123', Duration(milliseconds: 400));

      var list = <int?>[];

      await Future.wait([
        Future.delayed(Duration(milliseconds: 125), () {
          list.add(cache['123']);
        }),
        Future.delayed(Duration(milliseconds: 500), () {
          list.add(cache['123']);
        })
      ]);

      expect(list, [123, null]);
    });

    test('expiration', () async {
      cache.set('123', 123, expiration: Duration(milliseconds: 300));

      var list = <int?>[];

      await Future.wait([
        Future.delayed(Duration(milliseconds: 150), () {
          list.add(cache['123']);
        }),
        Future.delayed(Duration(milliseconds: 400), () {
          list.add(cache['123']);
        })
      ]);

      expect(list, [123, null]);
    });
  });
}
