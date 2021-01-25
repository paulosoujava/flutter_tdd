import '../../../../presentention/presenters/presenters.dart';
import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(authentication: makeRemoteAuthentication(), validation: makeLLoginValidation());
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(authentication: makeRemoteAuthentication(), validation: makeLLoginValidation());
}
