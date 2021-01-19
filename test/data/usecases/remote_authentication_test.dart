import 'package:faker/faker.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/domain/usecases/usecases.dart';
import 'package:flutter_application_1/data/http/http.dart';
import 'package:flutter_application_1/data/usecases/usecases.dart';
import 'package:flutter_application_1/domain/helpers/helpers.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  AuthenticationParams params;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url, method: 'post');
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
  });

  test('Should call HttpClient with correct values ', () async {
    //! 3 `a` Arange Action Assert
    //?Arange
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenAnswer((_) async => {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

    //setUp(()
    //?Action
    await sut.auth(params);
    //?Assert
    verify(httpClient.request(url: url, method: 'post', body: {'email': params.email, 'password': params.password}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400 ', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404 ', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500 ', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw invalid credentials error if httpclient returns 401 ', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should throw invalid credentials error if httpclient returns 401 ', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body'))).thenAnswer((_) async => {'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });
}
