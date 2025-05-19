import 'package:flutter/material.dart';

class Timer extends AnimatedWidget{
  const Timer({Key? key, required this.animation}): super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds : animation.value);
    var timerText = '${clockTimer.inMinutes.remainder(60).toString()} :'
    '${(clockTimer.inSeconds.remainder(60)% 60 ).toString().padLeft(2,'0')}';

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 150,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffA2B29F)
      ),
      child: Text(
        timerText,
        style: const TextStyle(
          fontSize: 35, color: Colors.black
        ),
      ),
    );
  }
}