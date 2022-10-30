import 'package:cache/cache.dart';

void main() {
  var cache = Cache(deleteOnExpire: false);

  var stopwatch = Stopwatch()..start();

  for (var i = 0; i < 1000000; i++) {
    cache.set(i.toString(), i);
  }

  stopwatch.stop();

  print(stopwatch.elapsedMilliseconds);
}
