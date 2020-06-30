import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_net_app/domain/bloc/user/user_bloc.dart';
import 'package:golden_net_app/ui/pages/about_page.dart';
import 'package:golden_net_app/ui/widgets/two_page_slider.dart';

import 'contacts_page.dart';
import 'log_in_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TwoPageSlider(
      builder: (context, goForward) => Scaffold(
        appBar: AppBar(
          title: Text("Профиль"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
            bloc: context.bloc(),
            builder: (context, state) {
              Widget userInfo;
              if (state is UserLogedIn) {
                userInfo = Container(
                  height: 150,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 10),
                        ClipOval(
                          child: Image.asset(
                            'assets/profile.jpg',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Expanded(
                          child: Column(children: <Widget>[
                            Text(state.user.email),
                            Container(
                              width: 160,
                              child: RaisedButton(
                                  child: Text("Выйти"),
                                  onPressed: () => context
                                      .bloc<UserBloc>()
                                      .add(UserLogOut())),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is UserUpdating) {
                userInfo = Container(
                    height: 150.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                userInfo = Container(
                  height: 150.0,
                  child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                        children: <Widget>[
                          Text("Пользователь не найден"),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: RaisedButton(
                                    child: Text("Войти"),
                                    onPressed: () {
                                      goForward(
                                        builder: (context, goBack) => LogInPage(goBack: goBack,),
                                        transitionType: SharedAxisTransitionType.scaled
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              }
              return Column(
                children: <Widget>[
                  userInfo,
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text("О нас"),
                          leading: Icon(Icons.card_travel),
                          onTap: () {
                            goForward(
                              builder: (context, goBack) => AboutPage(goBack: goBack,),
                              transitionType: SharedAxisTransitionType.horizontal
                            );
                          },
                        ),
                        ListTile(
                          title: Text("Контакты"),
                          leading: Icon(Icons.book),
                          onTap: () {
                            goForward(
                              builder: (context, goBack) => ContactsPage(goBack: goBack,),
                              transitionType: SharedAxisTransitionType.horizontal
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
