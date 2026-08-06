import 'package:bloc_practice/features/home/bloc/internet_bloc.dart';
import 'package:bloc_practice/features/home/bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<InternetBloc, InternetState>(
          builder: (context, state) {
            if (state is InternetGainState) {
              return Text("Connected!");
            } else if (state is InternetLossState) {
              return Text("Not Connected");
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
