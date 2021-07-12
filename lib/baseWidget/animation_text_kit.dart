import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationTextKitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationTextKitState();
  static String get routeName => '/AnimationTextKitPage';
}

class _AnimationTextKitState extends State<AnimationTextKitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationTextKit'),
      ),
      body: Column(
        children: [
          _item(TypewriterAnimatedText(
            'Hello world!',
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 200),
          )),
          _item(ColorizeAnimatedText('ColorizeAnimatedText ',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              colors: [Colors.red, Colors.blueAccent])),
          _item(FadeAnimatedText('FadeAnimatedText')),
          _item(FlickerAnimatedText('FadeAnimatedText')),
          _item(RotateAnimatedText('RotateAnimatedText')),
          _item(ScaleAnimatedText('ScaleAnimatedText')),
          TextLiquidFill(text: 'TextLiquidFill'),
          _item(TyperAnimatedText('TyperAnimatedText',
              speed: Duration(milliseconds: 400))),
        ],
      ),
    );
  }

  Widget _item(AnimatedText text) {
    return AnimatedTextKit(
      animatedTexts: [text],
      totalRepeatCount: 4,
      pause: const Duration(milliseconds: 500),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
