import 'package:flutter/material.dart';

Widget backTalkWithUs() {
  return InkWell(
    onTap: null,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.question_answer, color: Colors.black),
          ),
          Text('Fale Conosco', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget entryField(String title, {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: isPassword,
          keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
          decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
        ),
      ],
    ),
  );
}

Widget submitButton(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    child: Text(
      'Login',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('ou'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget facebookButton() {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff1959a9),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text('f', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400)),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff2872ba),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text('Login com o Facebook', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    ),
  );
}

Widget createAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => null));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'O que? Não tem uma conta ainda?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Criar Agora',
            style: TextStyle(color: Color(0xfff79c4f), fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget title() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(text: 'C', style: TextStyle(color: Colors.black, fontSize: 30), children: [
      TextSpan(
        text: 'arteira',
        style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
      ),
      TextSpan(
        text: ' D',
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
      TextSpan(
        text: 'igital',
        style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
      ),
    ]),
  );
}

Widget emailPasswordWidget() {
  return Column(
    children: <Widget>[
      entryField("Email"),
      entryField("Senha", isPassword: true),
    ],
  );
}
