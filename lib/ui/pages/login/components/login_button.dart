import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../pages.dart';
import './size_screem.dart';

class SubmitButton extends StatefulWidget {
  SubmitButton({Key key}) : super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return Container(
      child: StreamBuilder<bool>(
          stream: presenter.isFormValidStream,
          builder: (context, snapshot) {
            return RaisedButton(
              onPressed: snapshot.data == true ? presenter.auth : null,
              color: Color(0xfffbb448),
              child: Container(
                width: sizeScreenWidth(context),
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            );
          }),
    );
  }
}
