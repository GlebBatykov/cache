<div align="center">

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

Сохранить значения в кэш:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  cache.set('key', '1o23fjadijs');
}
```

Сохранить и получить значения из кэша:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  cache.set('key', '1o23fjadijs');

  print(cache['name']);

  print(cache['key']);
}
```

Сохранить значения и указать для них срок жизни:

```dart
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
```

Записать значения и удалить их все:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.clear();

  print(cache['name']);
}
```
