import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixels_app/cubit/splash_cubit/splash_cubit.dart';
import 'package:pixels_app/utils/app_Png.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  SplashCubit splashCubit = SplashCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => splashCubit,
      child: BlocListener<SplashCubit, SplashState>(
        bloc: splashCubit.getNavigation(),
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.pushNamed(context, '/home');
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
