
import 'package:flutter/material.dart';
import 'package:mtg_roulette/tools/tools.dart';

import 'package:mtg_roulette/constants/colors.dart';


class CenterButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: getScreenHeight(context) / 2 - getScreenWidth(context) / 16,
      left: getScreenWidth(context) / 2 - getScreenWidth(context) / 16,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(45 / 360),
        child: Container(
          width: getScreenWidth(context) / 8,
          height: getScreenWidth(context) / 8,
          decoration: BoxDecoration(
            color: AppColors.centerButton,
            //border: Border.all(),
          ),
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(-45 / 360),
            child: Icon(
              Icons.menu,
            ),
          ),
        ),
      ),
    );
  }
}