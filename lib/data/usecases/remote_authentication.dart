import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';

import '../http/http.dart';

import '../model/model.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;
  final String method;

  RemoteAuthentication({@required this.httpClient, @required this.url, @required this.method});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: RemoteAuthenticationParams.fromDomain(params).toJson());
      return RemoteAccounModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

//! aqui se tem o conhecimento sobre a api por isso o toJson esta aqui e nao no AuthenticationParams
class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

//! responsavel por gerar uma instancia de si mesmo apartir da classe de um dominio que é correspondente a ele
  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => RemoteAuthenticationParams(email: params.email, password: params.password);

  Map toJson() => {'email': email, 'password': password};
}
