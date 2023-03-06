import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/menu/set_menu_ready_command.dart';
import 'package:mtg_roulette/commands/player/clear_all_highlighted_command.dart';
import 'package:mtg_roulette/commands/menu/pick_random_player_command.dart';
import 'package:mtg_roulette/commands/menu/toggle_menu_command.dart';
import 'package:mtg_roulette/commands/menu/toggle_menu_ready_command.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/menu_model.dart';
import 'package:mtg_roulette/tools/tools.dart';

import 'package:mtg_roulette/const/color_constants.dart';

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
    SetMenuReadyCommand().run(false);
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        SetMenuReadyCommand().run(true);
      }
    });
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? _animationController.forward() : _animationController.reverse();
    });
    ToggleMenuCommand().run();
  }

  @override
  Widget build(BuildContext context) {
    // ugly ?
    double _top = widget.top ?? screenHeight(context) / 2;
    double _left = widget.left ?? screenWidth(context) / 2;

    double w = screenWidth(context) * SizeConstants.centerMenuButtonWidth;
    double h = screenWidth(context) * SizeConstants.centerMenuButtonWidth;

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
          icon: Icon(Icons.restart_alt),
          callback: () {
            Navigator.pop(context);
            ToggleMenuCommand().run();
          },
        ),
        AnimatedMenuElement(
          w: w,
          h: h,
          color: ColorConstants.main,
          defaultLeft: _left - w / 2,
          defaultTop: _top - w / 2,
          openLeft: _left + _left / 2 - w / 2,
          openTop: _top - w / 2,
          icon: Icon(Icons.question_mark),
          callback: () {
            print("clicked");
            PickRandomPlayerCommand().run(false);
          },
        ),
        // ---------------------

        Positioned(
          top: _top - h / 2,
          left: _left - w / 2,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _handleClicked();
              },
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: ColorConstants.centerButton,
                ),
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(-45 / 360),
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: FittedBox(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: _animationController,
                      ),
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
  final Icon icon;
  final Function callback;

  AnimatedMenuElement({
    Key? key,
    required this.w,
    required this.h,
    this.color = ColorConstants.white,
    required this.defaultTop,
    required this.defaultLeft,
    required this.openTop,
    required this.openLeft,
    required this.icon,
    required this.callback,
  }) : super(key: key);

  @override
  State<AnimatedMenuElement> createState() => _AnimatedMenuElementState();
}

class _AnimatedMenuElementState extends State<AnimatedMenuElement> {
  late double _top, _left;
  bool  built = false;

  @override
  void initState() {
    _top = widget.defaultTop;
    _left = widget.defaultLeft;
    super.initState();
  }

  // todo provider to detect parent clicked ?

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(
      builder: (context, menu, child) {
        return AnimatedPositioned(
          top: (menu.isOpen) ? widget.openTop : _top,
          left: (menu.isOpen) ? widget.openLeft : _left,
          width: widget.w,
          height: widget.h,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
              ),
              child: InkWell(

                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(-45 / 360),
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: FittedBox(
                      child: widget.icon,
                    ),
                  ),
                ),
                onTap: (menu.isOpen && menu.isReady) ? () => widget.callback() : () {print('nope');},
              ),
            ),
          ),
        );
      },
    );
  }
}
