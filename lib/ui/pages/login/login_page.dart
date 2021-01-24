import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/pages/login/components/size_screem.dart';

import 'components/components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      entryField(),
                      SizedBox(height: 20.0),
                      submitButton(context),
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
      ),
    );
  }
}
