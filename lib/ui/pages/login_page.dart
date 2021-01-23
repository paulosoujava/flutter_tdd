import 'package:flutter/material.dart';

import 'components/components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: height * .2),
                Container(
                  height: height * .3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xfffbb448),
                          Color(0xfff7892b),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                          blurRadius: 4,
                          color: Colors.black,
                        ),
                      ],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
                  child: Center(child: title(context)),
                ),
                SizedBox(height: 50.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      emailPasswordWidget(),
                      SizedBox(height: 20.0),
                      submitButton(context),
                      forgetPassword(),
                      divider(),
                      facebookButton(),
                      SizedBox(height: height * .055),
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
