import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({@required String url, @required String method, Map body}) async {
    final headers = {'content-tye': 'application/json', 'accept': 'application/json'};
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: jsonBody);
    return _handleReponse(response);
  }

  Map _handleReponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 400:
        throw HttpError.badRequest;
        break;
      case 401:
        throw HttpError.unauthorized;
        break;
      case 403:
        throw HttpError.forbidden;
        break;
      case 204:
        return null;
      default:
        return throw HttpError.serverError;
    }
  }
}
