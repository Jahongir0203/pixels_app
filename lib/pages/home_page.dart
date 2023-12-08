import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixels_app/pages/widgets/getBody_widget.dart';
import 'package:pixels_app/service/network_service.dart';

import '../cubit/home_cubit/home_cubit.dart';
import 'widgets/buildAppBar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeCubit homeCubit = HomeCubit(NetworkService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit..getPhotos(),
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(),
            body: RefreshIndicator(
              onRefresh: ()async{
                homeCubit.getPhotos();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: getBody(context, state, homeCubit),
              ),
            ),
          );
        },
      ),
    );
  }
}
