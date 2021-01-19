import '../../domain/entities/entities.dart';

import '../http/http_error.dart';

class RemoteAccounModel {
  final String _accessToken;

  RemoteAccounModel(this._accessToken);

  factory RemoteAccounModel.fromJson(Map json) {
    return json.containsKey('accessToken') ? RemoteAccounModel(json['accessToken']) : throw HttpError.invalidaData;
  }
  AccountEntity toEntity() => AccountEntity(_accessToken);
}
