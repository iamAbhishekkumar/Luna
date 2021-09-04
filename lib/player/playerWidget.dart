import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:line_icons/line_icons.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import 'positionData.dart';
import 'seekBar.dart';

class PlayerWidget extends StatefulWidget {
  final String url;
  const PlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final _player = AudioPlayer();

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: _width * 0.1),
          child: StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                onChanged: _player.seek,
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LineIcons.random,
                    color: Colors.grey,
                    size: _width * 0.1,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LineIcons.stepBackward,
                    color: Colors.grey,
                    size: _width * 0.1,
                  )),
              StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: CircularProgressIndicator(),
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 64.0,
                      onPressed: _player.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: Icon(Icons.pause),
                      iconSize: 64.0,
                      onPressed: _player.pause,
                    );
                  } else {
                    return IconButton(
                      icon: Icon(Icons.replay),
                      iconSize: 64.0,
                      onPressed: () => _player.seek(Duration.zero),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.stepForward,
                  color: Colors.grey,
                  size: _width * 0.1,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.retweet,
                  color: Colors.grey,
                  size: _width * 0.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _initAudioPlayer() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.url)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }
}
