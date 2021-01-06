import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'package:flutter_application_1/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  final String method;

  RemoteAuthentication({@required this.httpClient, @required this.url, @required this.method});

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method, Map body});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url, method: 'post');
  });

  test('Should call HttpClient with correct values ', () async {
    //! 3 `a` Arange Action Assert
    //?Arange
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    //setUp(()
    //?Action
    await sut.auth(params);
    //?Assert
    verify(httpClient.request(url: url, method: 'post', body: {'email': params.email, 'password': params.password}));
  });
}
