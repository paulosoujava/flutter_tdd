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
  StreamController<String> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadController;

  void initStreams() {
    emailErrorConttroller = StreamController<String>();
    passwordErrorConttroller = StreamController<String>();
    mainErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorConttroller.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorConttroller.stream);
    when(presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadStream).thenAnswer((_) => isLoadController.stream);
  }

  void closeStreams() {
    emailErrorConttroller.close();
    passwordErrorConttroller.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    initStreams();
    mockStreams();

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
      reason: "When a TextFomrField has only one text child, means it has no erros one of the childs is always the  label text",
    );
    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
    );

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
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

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, null);
  });

  testWidgets('Should call authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    await tester.tap(find.byType(RaisedButton));

    verify(presenter.auth()).called(1);
  });

  testWidgets('Should presenter loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should presenter  hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadController.add(true);
    await tester.pump();
    isLoadController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should presenter error message if authentication fails', (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });
}
