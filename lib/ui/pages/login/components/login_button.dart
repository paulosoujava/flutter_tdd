import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/pages/pages.dart';

import './size_screem.dart';

StreamBuilder submitButton(context, LoginPresenter presenter) {
  return StreamBuilder<bool>(
      stream: presenter.isFormValidController,
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
      });
}
