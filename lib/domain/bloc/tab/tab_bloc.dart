import 'dart:async';

import 'package:bloc/bloc.dart';

class TabBloc extends Bloc<int, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}