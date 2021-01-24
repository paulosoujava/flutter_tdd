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
  StreamController<String> passwordErrorConttroller;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorConttroller = StreamController<String>();
    passwordErrorConttroller = StreamController<String>();
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorConttroller.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorConttroller.stream);
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorConttroller.close();
    passwordErrorConttroller.close();
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

  testWidgets('Should presenter no error if email is valid, returns error null', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorConttroller.add(null);
    await tester.pump();

    expect(
        find.descendant(
          of: find.bySemanticsLabel(('Email')),
          matching: find.byType(Text),
        ),
        findsOneWidget);
  });

  testWidgets('Should presenter no error if email is valid, returns empty', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorConttroller.add('');
    await tester.pump();

    expect(
        find.descendant(
          of: find.bySemanticsLabel(('Email')),
          matching: find.byType(Text),
        ),
        findsOneWidget);
  });

  testWidgets('Should presenter error if passeword is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorConttroller.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should presenter no error if passeword is valid, returns error null', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorConttroller.add(null);
    await tester.pump();

    expect(
        find.descendant(
          of: find.bySemanticsLabel(('Senha')),
          matching: find.byType(Text),
        ),
        findsOneWidget);
  });

  testWidgets('Should presenter no error if passeword is valid, returns empty', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorConttroller.add('');
    await tester.pump();

    expect(
        find.descendant(
          of: find.bySemanticsLabel(('Senha')),
          matching: find.byType(Text),
        ),
        findsOneWidget);
  });
}
