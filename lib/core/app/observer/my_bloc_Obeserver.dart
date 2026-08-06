import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObeserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log("Create $bloc");
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log("Create $event $bloc");
    super.onEvent(bloc, event);
  }
}
