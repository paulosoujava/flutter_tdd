import 'package:meta/meta.dart';

import '../../cache/cache.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSaveCurrentToken implements SaveCurrentToken {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentToken({@required this.saveSecureCacheStorage});

  @override
  Future<void> saveToken(Token value) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: value.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
