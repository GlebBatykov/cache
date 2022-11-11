<div align="center">

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Про Cache](#про-cache)
- [Set](#set)
- [Get](#get)
- [Delete](#delete)
- [Has](#has)
- [Expiration](#expiration)
  - [Change expiration](#change-expiration)
  - [Delete callback](#delete-callback)
- [Clear](#clear)

# Про Cache

`Cache` предоставляет:

- кэширование значений в памяти;
- автоматическое удаление значений спустя установленные время.

# Set

Для кэширования значений используйте метод `set`.

Пример использования метода `set` для установки значений:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');
}
```

# Get

Для получения значений используйте метод `get` или оператор `[]`.

Пример получения значений по ключу:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache.get('name'));

  print(cache['cache']);
}
```

Ожидаемый вывод:

```dart
Alex
Alex
```

# Delete

Удалить значение вы можете при помощи метода `delete`.

Пример удаления значения:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.delete('name');

  print(cache['name']);
}
```

Ожидаемый вывод:

```dart
Alex
null
```

# Has

Проверить наличие значение по ключу можно при помощи метода `has`.

Пример проверки наличия значения:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache.has('name'));

  print(cache.has('key'));
}
```

Ожидаемый вывод:

```dart
true
false
```

# Expiration

В `Cache` есть автоматическая очистка значений спустя заданное время.

Задать время существования значения в кэше можно при помощи параметра `expirationSetting` метода `set`.

Пример установки времени существования значения:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(minutes: 15)));
}
```

Для очистки `Cache` существует интервал проверки значений на то истек ли их срок жизни. По умолчанию он равен 600 секунд.

Вы можете самостоятельно задать время интервала проверки значений при помощи параметра `checkPeriod` при создании экземпляра класса `Cache`.

Пример установки интервала проверки значений:

```dart
void main() {
    var cache = Cache(checkPeriod: const Duration(seconds: 5));
}
```

Если вы не планируете спустя время автоматически очищать значения вы можете отключить это при помощи параметра `deleteOnExpire`. По умолчанию он равен true.

## Change expiration

После записи значения вы можете изменить время его жизни при помощи метода `changeExpiration`.

Пример изменения время жизни значения:

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

При установке времени жизни значения вы можете так же назначить обработчик, который сработает во время удаления значения после истечения его срока жизни.

Если обработчик вернет true, то значение будет удалено. Если обработчик вернет false, то время жизни значения будет продлено на установленное ему время.

Пример установки обработчика:

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

Очистить все значения в кэше вы можете при помощи метода `clear`.

Пример очистки значения кэша:

```dart
void main() {
  var cache = Cache();

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.clear();

  print(cache['name']);
}
```

Ожидаемый вывод:

```dart
Alex
null
```
