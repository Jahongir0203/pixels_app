import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixels_app/cubit/home_cubit/home_cubit.dart';
import 'package:pixels_app/pages/widgets/buildTextField.dart';

import '../service/network_service.dart';
import 'widgets/buildAppBar.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key, required this.query}) : super(key: key);
  String query;
  HomeCubit homeCubit = HomeCubit(NetworkService());
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = query;
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit..searchPhotos(controller.text),
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(),
            body: RefreshIndicator(
              onRefresh: ()async{
                homeCubit.searchPhotos(query);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      buildTextField(() async {
                        homeCubit.searchPhotos(controller.text);
                      }, controller),
                      getBody(state),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getBody(HomeState state) {
    if (state.status == Status.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.status == Status.loaded) {
      return MasonryGridView.count(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: state.searchPhotoModel?.photos?.length,
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, '/download', arguments:
                  state.searchPhotoModel!.photos![index].src!
                  .large2x ?? '',);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                  imageUrl:
                  state.searchPhotoModel!.photos![index].src!.portrait ??
                      ''),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('Error'),
      );
    }
  }
}
