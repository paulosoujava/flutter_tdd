import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;

  Token(this.token);

  @override
  List<Object> get props => [token];
}
