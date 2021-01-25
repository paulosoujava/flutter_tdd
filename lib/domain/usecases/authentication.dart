import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String username;
  final String password;

  AuthenticationParams({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];
}
