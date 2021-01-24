import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class EntryFields extends StatefulWidget {
  EntryFields({Key key}) : super(key: key);

  @override
  _EntryFieldsState createState() => _EntryFieldsState();
}

class _EntryFieldsState extends State<EntryFields> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              StreamBuilder<String>(
                  stream: presenter.emailErrorStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: presenter.validateEmail,
                      decoration: InputDecoration(
                          labelText: "Email",
                          errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          focusColor: Colors.orange,
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          fillColor: Colors.white70),
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<String>(
                  stream: presenter.passwordErrorStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onChanged: presenter.validatePassword,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          focusColor: Colors.orange,
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          fillColor: Colors.white70),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
