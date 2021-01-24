import 'package:flutter/material.dart';

import 'components/components.dart';
import '../login/components/components.dart';
import '../../pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadController.listen((isLoading) {
            if (isLoading) {
              loading(context);
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });
          presenter.mainErrorController.listen((error) {
            if (error != null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red[900],
                content: Text(
                  error,
                  textAlign: TextAlign.center,
                ),
              ));
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
                          entryField(presenter),
                          SizedBox(height: 20.0),
                          submitButton(context, presenter),
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
