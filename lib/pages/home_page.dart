import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixels_app/bloc/main_bloc/main_bloc.dart';
import 'package:pixels_app/pages/widgets/getBody_widget.dart';
import 'package:pixels_app/service/network_service.dart';

import 'widgets/buildAppBar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  MainBloc mainBloc = MainBloc(NetworkService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mainBloc,
      child: BlocBuilder<MainBloc, MainState>(
        bloc: mainBloc..add(MainGetPhotos()),
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                mainBloc.add(MainGetPhotos());
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: getBody(context, state, mainBloc),
              ),
            ),
          );
        },
      ),
    );
  }
}
