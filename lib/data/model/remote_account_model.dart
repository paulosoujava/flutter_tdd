import 'package:flutter_application_1/domain/entities/account_entity.dart';

class RemoteAccounModel {
  final String _accessToken;

  RemoteAccounModel(this._accessToken);

  factory RemoteAccounModel.fromJson(Map json) => RemoteAccounModel(json['accessToken']);
  AccountEntity toEntity() => AccountEntity(_accessToken);
}
