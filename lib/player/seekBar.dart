import 'dart:math';

import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(Duration(milliseconds: value.round()));
            }
          },
        ),
        Text(_durationText, style: Theme.of(context).textTheme.caption),
        Text(_positionText, style: Theme.of(context).textTheme.caption),
      ],
    );
  }

  String get _durationText =>
      "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  String get _positionText =>
      "${widget.position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}
