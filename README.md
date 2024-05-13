# Modak API

Modak API

모두의 도감 API wrapper

- [Examples](#example)
- [Branch](#branch)
- [DTO](#dto)
- [Test](#test)

# Example

Create modak API object

```dart
m = Modak(
    token: Token.parseFromString("accessToken"),
    refreshToken: "refreshToken",
    endpoint: Endpoint(host: "host", port: 1234)
);
```

Get collection list (uuid)

```dart
final collectionsUUID = m.collection.getCollectionsUUID(0, 100);
```

Post collection

```dart
final collection = Collection(1, GeoLocation(0, 0, 0, 0), null);
await m.collection.postCollection("image file path", collection);
```

Get username's article list (link)

```dart
final articleLinks = m.article.getLinksByUsername("username");
print(articleLinks.links);
```

Get article by link

```dart
final article = m.article.getArticle("link");
print(article.title);
print(article.content);
```

# Branch

- master: production branch, must be tested
- main: develop branch

# DTO

DTO use json serialize

```bash
dart run build_runner build --delete-conflicting-outputs
```

# Test

### Test Coverage

Test with coverage

```bash
dart pub global run coverage:test_with_coverage
```

Need genhtml, if Window follow [this steps](https://fredgrott.medium.com/lcov-on-windows-7c58dda07080) to insall genhtml

```bash
genhtml -o coverage/html coverage/lcov.info
```
