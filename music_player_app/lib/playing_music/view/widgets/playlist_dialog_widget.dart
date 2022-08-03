import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../playlist/view_model/fuctions/playlist_functions.dart';
import '../../../utilities/view/colors.dart';

class PlaylistDialogWidget extends StatelessWidget {
  final SongModel songListPlay;
  final dynamic id;
  const PlaylistDialogWidget(
      {Key? key, required this.songListPlay, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProviderFuctions>(
      builder: (context, value, child) {
        return value.playlistNotifier.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                      background1,
                      background2,
                    ],
                  ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Provider.of<MusicUtils>(context, listen: false)
                          .addPlaylistBtn(context);
                    },
                    style: TextButton.styleFrom(
                        primary: kWhite, elevation: 2, backgroundColor: kAmber),
                    child: Text(
                      "Create Playlist",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                ),
              )
            : BodyContainer(
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = value.playlistNotifier[index];
                    return ListTile(
                      title: MainTextWidget(
                        title: data.name,
                      ),
                      subtitle: MainTextWidget(
                        title: '${data.songList.length}',
                      ),
                      leading: Icon(
                        Icons.playlist_play_rounded,
                        color: kAmber,
                        size: 40,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 50,
                          color: Color.fromARGB(94, 255, 255, 255),
                        ),
                        onPressed: () {
                          if (value.playlistNotifier[index].songList
                              .contains(id)) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  ' ${songListPlay.title} allready exixt in ${value.playlistNotifier[index].name}',
                                  style: TextStyle(
                                    color: kWhite,
                                  ),
                                ),
                                backgroundColor: kAmber,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            value.playlistNotifier[index].songList.add(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  ' ${songListPlay.title},Added To Playlist ${value.playlistNotifier[index].name}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: kWhite,
                                  ),
                                ),
                                backgroundColor: Colors.blue[900],
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: kAmber,
                      indent: 15,
                      endIndent: 10,
                      thickness: 3,
                    );
                  },
                  itemCount: value.playlistNotifier.length,
                ),
              );
      },
    );
  }
}
