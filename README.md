<div align="center">

**Languages:**
  
[![pub package](https://img.shields.io/pub/v/mcache.svg?label=mcache&color=blue)](https://pub.dev/packages/mcache)

[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [About Cache](#about-cache)
- [Set](#set)
- [Get](#get)
- [Update](#update)
- [Delete](#delete)
- [Has](#has)
- [Expiration](#expiration)
  - [Change expiration](#change-expiration)
  - [Delete callback](#delete-callback)
- [Clear](#clear)

# About Cache

`Cache` provides:

- caching of values in memory;
- automatic deletion of values after expiration.

# Set

To cache values, use the `set` method.

Example of using the `set` method to set values:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');
}
```

# Get

To get the values, use the `get` method or the `[]` operator.

Example of getting values by key:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache.get('name'));

  print(cache['cache']);
}
```

Expected output:

```dart
Alex
Alex
```

# Update

You can update an existing value and update its lifetime using the `update` method.

Example of updating a value:

```dart
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
```

Expected output:

```dart
Tom
null
```

# Delete

You can delete a value using the `delete` method.

Example of deleting a value:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.delete('name');

  print(cache['name']);
}
```

Expected output:

```dart
Alex
null
```

# Has

You can check the presence of a key value using the `has` method.

Example of checking for the presence of a value:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache.has('name'));

  print(cache.has('key'));
}
```

Expected output:

```dart
true
false
```

# Expiration

In `Cache` there is an automatic clearing of values after a specified time.

You can set the lifetime of the value in the cache using the `expirationSetting` parameter of the `set` method.

Example of setting the lifetime of a value:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(minutes: 15)));
}
```

To clear the `Cache`, there is an interval for checking the values to see if their lifetime has expired. By default, it is 600 seconds.

You can independently set the time of the interval for checking values using the `checkPeriod` parameter when creating an instance of the `Cache` class.

Example of setting the interval for checking values:

```dart
void main() {
    var cache = Cache(checkPeriod: const Duration(seconds: 5));
}
```

If you do not plan to automatically clear the values after a while, you can disable this by using the `deleteOnExpire` parameter. By default, it is true.

## Change expiration

After writing the value, you can change its lifetime using the `changeExpiration` method.

Example of changing the lifetime of a value:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(minutes: 5)));

  cache.changeExpiration(
      'name', ExpirationSetting(expiration: const Duration(minutes: 1)));
}
```

## Delete callback

When setting the lifetime of a value, you can also assign a handler that will trigger when the value is deleted after its expiration.

If the handler returns true, the value will be deleted. If the handler returns false, the lifetime of the value will be extended by the time set for it.

Example of installing a handler:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex',
      expirationSetting: ExpirationSetting(
          expiration: const Duration(minutes: 5),
          onDelete: (value) {
            print(value);

            return true;
          }));
}
```

# Clear

You can clear all the values in the cache using the `clear` method.

Example of clearing the cache value:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.clear();

  print(cache['name']);
}
```

Expected output:

```dart
Alex
null
```
