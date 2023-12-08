import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pixels_app/cubit/home_cubit/home_cubit.dart';
import 'package:pixels_app/service/network_service.dart';
import 'package:pixels_app/utils/app_Colors.dart';
import 'package:pixels_app/utils/app_Text_style.dart';

class DownloadPage extends StatelessWidget {
  DownloadPage({Key? key, required this.url}) : super(key: key);
  String url;
  HomeCubit homeCubit = HomeCubit(NetworkService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Container(
                child: PhotoView(
                  imageProvider: NetworkImage(url),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 30,
                  ),
                  child: InkWell(
                    onTap: () async {
                      homeCubit.downloadPhotos(url);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.kDownloadColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Download',
                          style: AppTextStyle.kHintTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
