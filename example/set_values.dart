import 'package:cache/cache.dart';

void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  cache.set('key', '1o23fjadijs');
}
