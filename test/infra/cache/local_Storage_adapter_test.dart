import 'package:test/test.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_application_1/infra/cache/cache.dart';

class FluterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FluterSecureStorageSpy fluterSecureStorageSpy;
  LocalStorageAdapter sut;
  String key;
  String value;

  setUp(() {
    fluterSecureStorageSpy = FluterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: fluterSecureStorageSpy);
    key = faker.lorem.word();
    value = faker.lorem.word();
  });

  test('Should call save secure wiith correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(fluterSecureStorageSpy.write(key: key, value: value));
  });

  test('Should throws save secure throws', () async {
    when(fluterSecureStorageSpy.write(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());
    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
