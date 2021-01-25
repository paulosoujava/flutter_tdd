import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:faker/faker.dart';

import 'package:mockito/mockito.dart';

import 'package:flutter_application_1/data/http/http_error.dart';
import 'package:flutter_application_1/infra/http/http.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpsUrl();
  });
  group('invalid method', () {
    test("Should throw ServerError if invalid method is provided", () {
      final future = sut.request(url: url, method: 'invalid_method ', body: {'any_key': 'any_value'});

      expect(future, throwsA(HttpError.serverError));
    });
  });
  group('verb post', () {
    PostExpectation mockRequest() => when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test("Should call post with correct values", () async {
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        client.post(
          url,
          headers: {'content-tye': 'application/json', 'accept': 'application/json'},
          body: '{"any_key":"any_value"}',
        ),
      );
    });

    test("Should call post without body", () async {
      await sut.request(
        url: url,
        method: 'post',
      );

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });

    test("Should return data if post return 200", () async {
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {'any_key': 'any_value'});
    });

    test("Should return  null if post returns 200 with no data", () async {
      mockResponse(200, body: '');
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });

    test("Should return  null if post returns 204", () async {
      mockResponse(204, body: '');
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });

    test("Should return  null if post returns 204 with data", () async {
      mockResponse(204);
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });

    test("Should return BadRequestError if post returns 400", () {
      mockResponse(400);
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.badRequest));
    });

    test("Should return BadRequestError if post returns 400 without data", () {
      mockResponse(400, body: '');
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.badRequest));
    });

    test("Should return UnauthorizedErrpr if post returns 401", () {
      mockResponse(401);
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.unauthorized));
    });

    test("Should return ForbiddenError if post returns 403", () {
      mockResponse(403);
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.forbidden));
    });

    test("Should return NotFoundError if post returns 404", () {
      mockResponse(404);
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.notFound));
    });

    test("Should return ServerError if post returns 500", () {
      mockResponse(500);
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.serverError));
    });

    test("Should return ServerError if post throws", () {
      mockError();
      final future = sut.request(
        url: url,
        method: 'post',
      );

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
