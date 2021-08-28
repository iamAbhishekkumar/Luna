import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'playerWidget.dart';

const kUrl1 = 'deo';

class SoundsPage extends StatefulWidget {
  @override
  _SoundsPageState createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  AudioPlayer mainPlayer = AudioPlayer();
  AudioCache? audioCache;

  PlayerState playerState = PlayerState.STOPPED;
  bool get isPlaying => playerState == PlayerState.PLAYING;

  String? localFilePath;

  @override
  void initState() {
    mainPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioCache = AudioCache(fixedPlayer: mainPlayer);
    AudioPlayer.logEnabled = true;

    mainPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        playerState = PlayerState.STOPPED;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    mainPlayer.dispose();
    super.dispose();
  }

  // Future _loadFile() async {
  //   final bytes = await http.readBytes(Uri.parse(kUrl1));
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = io.File('${dir.path}/audio.mp3');

  //   await file.writeAsBytes(bytes);
  //   if (file.existsSync()) {
  //     setState(() => localFilePath = file.path);
  //   }
  // }

  Widget remoteUrl() {
    return const SingleChildScrollView(
      child: _Tab(
        children: [
          Text(
            'Sample 1 ($kUrl1)',
            key: Key('url1'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          PlayerWidget(url: kUrl1)
        ],
      ),
    );
  }

  // Widget notification() {
  //   return _Tab(
  //     children: [
  //       const Text("Play notification sound: 'messenger.mp3':"),
  //       _Btn(
  //         txt: 'Play',
  //         onPressed: () =>
  //             audioCache.play('messenger.mp3', isNotification: true),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          remoteUrl(),
        ],
      ),
    );
  }
}

// reusage of widgets
class _Tab extends StatelessWidget {
  final List<Widget> children;

  const _Tab({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: children
                .map(
                  (w) => Container(
                    child: w,
                    padding: const EdgeInsets.all(6.0),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
