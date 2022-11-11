import 'package:mcache/mcache.dart';

void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.clear();

  print(cache['name']);
}
