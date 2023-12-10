import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixels_app/bloc/splash_bloc/splash_bloc.dart';
import 'package:pixels_app/utils/app_Png.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  SplashBloc splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        bloc: splashBloc..add(SplashEvent()),
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              AppPng.kSplashPng,
              height: 150,
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
