import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixels_app/pages/download_page.dart';
import 'package:pixels_app/service/category_service.dart';

import '../../cubit/home_cubit/home_cubit.dart';
import 'buildCategories.dart';
import 'buildTextField.dart';
import '../search_page.dart';

getBody(BuildContext context, HomeState state, HomeCubit homeCubit) {
  TextEditingController controller = TextEditingController();
  if (state.status == Status.loading) {
    return Center(
      child: CircularProgressIndicator(),
    );
  } else if (state.status == Status.loaded) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          buildTextField(
                () {
              Navigator.pushNamed(
                  context, '/search', arguments: controller.text);
            },
            controller,
          ),
          buildCategories(),
          MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.photoModel?.photos?.length,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/download',
                      arguments: state.photoModel!.photos![index].src!
                          .large2x ?? ''
                  );
                },
                child: ClipRRect(
                  borderRadius:  BorderRadius.circular(25),
                  child: CachedNetworkImage(
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                      imageUrl:
                      state.photoModel!.photos![index].src!.portrait ??
                          ''),
                ),
              );
            },
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Text('Error'),
    );
  }
}
