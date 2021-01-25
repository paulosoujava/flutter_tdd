import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import '../login/components/components.dart';
import '../../pages/pages.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  _hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (currentFocus.hasFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            widget.presenter.isLoadStream.listen((isLoading) {
              if (isLoading) {
                loading(context);
              } else {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              }
            });
            widget.presenter.mainErrorStream.listen((error) {
              if (error != null) {
                Scaffold.of(context).showSnackBar(showSnack(context, error));
              }
            });
            return Container(
              height: sizeScreenHeight(context),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sizeScreenHeight(context) * .2),
                      header(),
                      SizedBox(height: 30.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Provider(
                          create: (_) => widget.presenter,
                          child: Column(
                            children: [
                              EntryFields(),
                              SizedBox(height: 20.0),
                              SubmitButton(),
                              forgetPassword(),
                              divider(),
                              facebookButton(),
                              SizedBox(height: sizeScreenHeight(context) * .055),
                              backTalkWithUs(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
