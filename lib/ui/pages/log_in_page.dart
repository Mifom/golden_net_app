import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/user/user_bloc.dart';
import 'package:golden_net_app/ui/widgets/two_page_slider.dart';

import 'sign_up_page.dart';

class LogInPage extends StatefulWidget {
  final Function goBack;

  const LogInPage({Key key, this.goBack}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String _email;

  String _password;

  Future<void> _showDialog({BuildContext context, String message}) async {
    await Future.delayed(Duration(milliseconds: 500));
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Вход не выполнен"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final topDecoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF393037), Color(0xFF988B7F), Color(0xFF3A3037)],
        ),
        shape: BoxShape.rectangle);

    // final mainDecoration = BoxDecoration(
    //     color: Colors.blueGrey[100],
    //     borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(64), topRight: Radius.circular(64)));
    return TwoPageSlider(
      builder: (context, goForward) => BlocBuilder<UserBloc, UserState>(
          bloc: context.bloc(),
          builder: (context, state) {
            if (state is UserLogedIn) {
              widget.goBack();
              return Center();
            }
            if (state is UserFailedLogIn) {
              _showDialog(context: context, message: state.message);
            }
            return Scaffold(
              body: Container(
                constraints: BoxConstraints.expand(
                  width: double.infinity,
                ),
                decoration: topDecoration,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () => widget.goBack(),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Вход",
                              style: Theme.of(context).accentTextTheme.headline4,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Добро пожаловать",
                              style: Theme.of(context).accentTextTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      decoration:
                                          InputDecoration(labelText: "Email"),
                                      validator: (val) => (!val.contains('@')
                                          ? 'Некорректный email'
                                          : null),
                                      onSaved: (val) => _email = val,
                                    ),
                                    TextFormField(
                                      decoration:
                                          InputDecoration(labelText: "Пароль"),
                                      validator: (val) => (val.length <= 5
                                          ? 'Пароль должен быть длиннее 5 символов'
                                          : null),
                                      onSaved: (val) => _password = val,
                                      obscureText: true,
                                    ),
                                    SizedBox(height: 30),
                                    Container(
                                      width: 200,
                                      child: RaisedButton(
                                        color: colorScheme.secondary,
                                        child: state is UserUpdating
                                            ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ))
                                            : Text(
                                                "Войти",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                        onPressed: () {
                                          final form = formKey.currentState;
                                          if (form.validate()) {
                                            form.save();
                                            context.bloc<UserBloc>().add(
                                                UserLogIn(
                                                    email: _email,
                                                    password: _password));
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: RaisedButton(
                                        child: Text("Зарегистрироваться"),
                                        onPressed: () {
                                          goForward(
                                            builder: (context, goBack) => SignUpPage(goBack: goBack,),
                                            transitionType: SharedAxisTransitionType.horizontal
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
