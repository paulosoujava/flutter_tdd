import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_application_1/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorConttroller;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorConttroller = StreamController<String>();
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorConttroller.stream);
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorConttroller.close();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
      reason: "When a TextFomrField has only one text child, means ot has no erros one of the childs is always the  label text",
    );
    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
    );

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, null);
  });

  testWidgets('Should call validateEmail with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel("Email"), email);

    verify(presenter.validateEmail(email));
  });

  testWidgets('Should call validatePassword with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel("Senha"), password);

    verify(presenter.validatePassword(password));
  });

  testWidgets('Should presenter error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorConttroller.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });
}
