import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_net_app/domain/bloc/tab/tab_bloc.dart';

main() {
  group("test TabBloc", () {
    for (var i = 0; i < 4; i++) {
      blocTest("goto $i page when $i passed",
        build: () async => TabBloc(),
        act: (bloc) => bloc.add(i),
        expect: i == 0 ? [] : [i]
      );
    }
  });
}
