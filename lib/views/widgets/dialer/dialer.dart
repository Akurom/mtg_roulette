import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/dialer/dialer_clear_command.dart';
import 'package:mtg_roulette/commands/dialer/dialer_remove_digit_command.dart';
import 'package:mtg_roulette/commands/dialer/dialer_set_to_counter_command.dart';
import 'package:mtg_roulette/commands/player/toggle_dialer_command.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/dialer_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:mtg_roulette/views/widgets/dialer/dialer_buttons.dart';
import 'package:mtg_roulette/views/widgets/dialer/dialer_digits.dart';
import 'package:provider/provider.dart';

class Dialer extends StatelessWidget {
  final PlayerModel player;

  const Dialer({required this.player});

  @override
  Widget build(BuildContext context) {
    DialerModel dialer = DialerModel();

    return ChangeNotifierProvider<DialerModel>.value(
      value: dialer,
      child: Stack(
        children: [

          if (player.watermark != null)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(player.color.withOpacity(0.1), BlendMode.dstATop),
                  image: AssetImage(player!.watermark!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

          Column(
            children: [
              DialerDigits(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ----- left
                  Container(
                    //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // cancel button
                        //RotatedButton(icon: Icon(Icons.cancel_outlined)),
                        DButton(
                          icon: Icons.cancel_rounded,
                          commandRun: () {
                            DialerClearCommand().run(dialer);
                            ToggleDialerCommand().run(player);
                          },
                        ),
                      ],
                    ),
                  ),

                  // ----- main
                  Expanded(
                    child: Column(
                      children: [
                        DialerButtons(
                          dialer: dialer,
                        ),
                      ],
                    ),
                  ),
                  // ----- right
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // backspace button
                      DButton(
                        icon: Icons.backspace_outlined,
                        commandRun: () {
                          DialerRemoveDigitCommand().run(dialer);
                        },
                      ),
                      // validation button
                      DButton(
                        icon: Icons.check,
                        commandRun: () {
                          if (dialer.count != 0) {
                            DialerSetToCounterCommand().run(dialer, player);
                            ToggleDialerCommand().run(player);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],),
    );
  }
}


typedef void VoidCallback();
typedef FutureCallback = Future<void> Function();

class DButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback commandRun;

  const DButton({required this.icon, required this.commandRun});

  @override
  Widget build(BuildContext context) {
    log('Dialer built.');
    return InkWell(
        child: Container(
          width: SizeConstants.centerMenuButtonWidth * screenWidth(context),
          height: SizeConstants.centerMenuButtonWidth * screenWidth(context),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: FittedBox(
              child: Icon(
                icon,
                color: ColorConstants.centerButton,
              ),
            ),
          ),
        ),
        onTap: commandRun
    );
  }
}

class RotatedButton extends StatelessWidget {
  final Icon icon;

  const RotatedButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    double w = screenWidth(context);
    double h = screenHeight(context);

    return RotationTransition(
      turns: AlwaysStoppedAnimation(45 / 360),
      child: InkWell(
        child: Container(
          width: SizeConstants.centerMenuButtonWidth * w,
          height: SizeConstants.centerMenuButtonWidth * w,
          decoration: BoxDecoration(
            color: ColorConstants.centerButton,
          ),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(-45 / 360),
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: FittedBox(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
