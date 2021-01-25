import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/domain/entities/token_entity.dart';
import 'package:flutter_application_1/data/cache/save_secure_cache_storage.dart';
import 'package:flutter_application_1/data/usecases/save_current_token/local_save_current_token.dart';
import 'package:flutter_application_1/domain/helpers/helpers.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  LocalSaveCurrentToken sut;
  Token secureToken;

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentToken(saveSecureCacheStorage: saveSecureCacheStorage);
    secureToken = Token(faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage  with correct values', () async {
    await sut.saveToken(secureToken);

    verify(saveSecureCacheStorage.saveSecure(key: 'token', value: secureToken.token));
  });

  test('Should throw UnexpectedErro if SaveSecureCacheStorage throws', () {
    when(saveSecureCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());

    final future = sut.saveToken(secureToken);

    expect(future, throwsA(DomainError.unexpected));
  });
}
