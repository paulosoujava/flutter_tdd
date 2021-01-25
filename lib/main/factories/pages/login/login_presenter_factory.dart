import '../../../../presentention/presenters/presenters.dart';
import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(authentication: makeRemoteAuthentication(), validation: makeLLoginValidation());
}
