import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  InternetBloc() : super(InternetIntialState()) {
    on<InternetGainEvent>((event, emit) {
      emit(InternetGainState());
    });

    on<InternetLossEvent>((event, emit) {
      emit(InternetLossState());
    });

    _listenConnectivity();
  }

  void _listenConnectivity() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final hasInternet =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (hasInternet) {
        add(InternetGainEvent());
      } else {
        add(InternetLossEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
