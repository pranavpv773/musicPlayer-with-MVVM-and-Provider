import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view/widgets/music_icons.dart';
import 'package:music_player_app/playing_music/view_model/music_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/images.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:provider/provider.dart';
import 'widgets/duration_state_widget.dart';
import 'widgets/duration_text.dart';
import 'widgets/music_artwork.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MusicUtils>(context, listen: false)
          .audioPlayer
          .currentIndexStream
          .listen((index) {
        if (index != null) {
          Provider.of<MusicUtils>(context, listen: false)
              .updateCurrentPlayingSongDetails(index);
        }
      });
      context.read<MusicUtils>().duration;
    });
    return Scaffold(
      backgroundColor: background1,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background1,
        title: const Text(
          "Now Playing",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => Search(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          )
        ],
      ),
      body: Consumer<MusicUtils>(builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                musicPlayBackground,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  child: MusicPlayArtwork(
                    id: context
                        .read<MusicUtils>()
                        .myMusic[context.read<MusicUtils>().currentIndex]
                        .id,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: MainTextWidget(
                    title: value.myMusic[value.currentIndex].title,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: MainTextWidget(
                    title: value.myMusic[value.currentIndex].artist
                                .toString() ==
                            '<unknown>'
                        ? "unknown Artist"
                        : value.myMusic[value.currentIndex].artist.toString(),
                  ),
                ),
              ),
              MusicIconsWidget(
                  myMusic: context
                      .read<MusicUtils>()
                      .myMusic[context.read<MusicUtils>().currentIndex]),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: const DurationStateWidget(),
                    ),
                    const MusicDurationTextWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    context.read<PlayMusicProvider>().previousButton(),
                    context.read<PlayMusicProvider>().playButton(),
                    context.read<PlayMusicProvider>().nextButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
