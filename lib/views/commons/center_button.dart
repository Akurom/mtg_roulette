import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/toggle_menu_command.dart';
import 'package:mtg_roulette/models/game_model.dart';
import 'package:mtg_roulette/tools/tools.dart';

import 'package:mtg_roulette/const/colors.dart';

import 'package:provider/provider.dart';

class CenterButton extends StatefulWidget {
  final double? top;
  final double? left;

  const CenterButton({this.top, this.left});

  @override
  State<CenterButton> createState() => _CenterButtonState();
}

class _CenterButtonState extends State<CenterButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleClicked() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? _animationController.forward() : _animationController.reverse();
    });
    ToggleMenuCommand().run();
  }

  @override
  Widget build(BuildContext context) {
    // ugly ?
    double _top = widget.top ?? getScreenHeight(context) / 2;
    double _left = widget.left ?? getScreenWidth(context) / 2;

    double w = getScreenWidth(context) / 8;
    double h = getScreenWidth(context) / 8;

    return Stack(
      children: [
        // --------- Menu elements
        AnimatedMenuElement(
          w: w,
          h: h,
          color: ColorConstants.white,
          defaultLeft: _left - w / 2,
          defaultTop: _top - w / 2,
          openLeft: _left / 2 - w / 2,
          openTop: _top - w / 2,
        ),
        AnimatedMenuElement(
          w: w,
          h: h,
          color: ColorConstants.white,
          defaultLeft: _left - w / 2,
          defaultTop: _top - w / 2,
          openLeft: _left + _left / 2 - w / 2,
          openTop: _top - w / 2,
        ),
        // ---------------------

        Positioned(
          top: _top - h / 2,
          left: _left - w / 2,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(45 / 360),
            child: GestureDetector(
              onTap: () {
                _handleClicked();
              },
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: ColorConstants.centerButton,
                  //border: Border.all(),
                ),
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(-45 / 360),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.pause_play,
                      progress: _animationController,
                      size: 34, // todo set size from themeData
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedMenuElement extends StatefulWidget {
  final double w;
  final double h;
  final Color color;
  final double defaultTop;
  final double defaultLeft;
  final double openTop;
  final double openLeft;

  AnimatedMenuElement({
    Key? key,
    required this.w,
    required this.h,
    this.color = ColorConstants.white,
    required this.defaultTop,
    required this.defaultLeft,
    required this.openTop,
    required this.openLeft,
  }) : super(key: key);

  @override
  State<AnimatedMenuElement> createState() => _AnimatedMenuElementState();
}

class _AnimatedMenuElementState extends State<AnimatedMenuElement> {
  late double _top, _left;

  @override
  void initState() {
    _top = widget.defaultTop;
    _left = widget.defaultLeft;
    super.initState();
  }

  // todo provider to detect parent clicked ?

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, game, child) {
        return AnimatedPositioned(
          top: (game.isMenuOpen) ? widget.openTop : _top,
          left: (game.isMenuOpen) ? widget.openLeft : _left,
          width: widget.w,
          height: widget.h,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(-45 / 360),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
