import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/dialer/dialer_add_digit_command.dart';
import 'package:mtg_roulette/models/dialer_model.dart';
import 'package:mtg_roulette/views/widgets/dialer/dialer_button.dart';




class DialerButtons extends StatelessWidget {
  final DialerModel dialer;
  const DialerButtons({required this.dialer});

  @override
  Widget build(BuildContext context) {

    return Container(

        child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        children: List.generate(10, (index) {
          return DialerButton(
              callback: () {
                DialerAddDigitCommand().run(dialer, index);
              },
              buttonValue: index);
        }),

    ),);
  }
}
