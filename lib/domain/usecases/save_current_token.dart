import '../entities/entities.dart';

abstract class SaveCurrentToken {
  Future<void> saveToken(Token value);
}
