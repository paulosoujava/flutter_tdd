import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadController.listen((isLoading) {
            if (isLoading) {
              loading(context);
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });
          widget.presenter.mainErrorController.listen((error) {
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
                      child: Column(
                        children: [
                          entryField(widget.presenter),
                          SizedBox(height: 20.0),
                          submitButton(context, widget.presenter),
                          forgetPassword(),
                          divider(),
                          facebookButton(),
                          SizedBox(height: sizeScreenHeight(context) * .055),
                          backTalkWithUs(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
