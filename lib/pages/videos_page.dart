import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixels_app/pages/widgets/buildTextField.dart';
import 'package:pixels_app/service/network_service.dart';
import 'package:video_player/video_player.dart';

import '../bloc/main_bloc/main_bloc.dart';

class VideosPage extends StatelessWidget {
  VideosPage({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  MainBloc mainBloc = MainBloc(NetworkService());
  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mainBloc,
      child: BlocBuilder<MainBloc, MainState>(
        bloc: mainBloc..add(MainGetVideos()),
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: buildTextField(() {}, controller),
                      ),
                      buildListView(context, state),
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

  buildListView(BuildContext context, MainState state) {
    if (state.status == Status.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.status == Status.loaded) {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: state.videoModel?.videos?.length ?? 0,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, '/playVideo',
                      arguments:
                          '${state.videoModel?.videos?[index].videoFiles?[0].link}');
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${state.videoModel?.videos?[index].image}'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      '${state.videoModel?.videos?[index].user?.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(onPressed: () {
                      mainBloc.add(MainDownloadPhotos('${state.videoModel?.videos?[index].videoFiles?[0].link}'));
                    }, icon: Icon(Icons.download)),
                  ],
                ),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.blue,
            thickness: 1.5,
          );
        },
      );
    } else {
      return Text('Error');
    }
  }
}
