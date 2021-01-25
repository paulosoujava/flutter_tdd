import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveCurrentToken makeSaveCurrentToken() {
  return LocalSaveCurrentToken(saveSecureCacheStorage: makeLocalStorageAdapter());
}
