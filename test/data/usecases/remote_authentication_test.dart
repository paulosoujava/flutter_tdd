import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  final String method;

  RemoteAuthentication({@required this.httpClient, @required this.url, @required this.method});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({@required String url, @required String method});
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
    //setUp(()
    //?Action
    await sut.auth();
    //?Assert
    verify(httpClient.request(url: url, method: 'post'));
  });
}
