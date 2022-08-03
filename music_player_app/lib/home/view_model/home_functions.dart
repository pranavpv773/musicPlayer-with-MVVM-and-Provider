// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../all_songs/view/all_songs.dart';

class HomeFunctions with ChangeNotifier {
  List<SongModel> allSongs = [];

  Future<void> scan(BuildContext context) async {
    await Future.delayed(
      const Duration(
        seconds: 15,
      ),
    );
    if (AllSongs.songs.isEmpty) {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: background2,
          ),
          backgroundColor: background2,
          message: "no Songs found",
        ),
      );
    }
    return showTopSnackBar(
      context,
      const CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned",
      ),
    );
  }
}