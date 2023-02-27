import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/dialer/dialer_add_digit_command.dart';
import 'package:mtg_roulette/models/dialer_model.dart';


typedef void VoidCallback();

class DialerButton extends StatelessWidget {
  final VoidCallback callback;
  final int buttonValue;

  const DialerButton({required this.callback, required this.buttonValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Center(
          child: Text(
            buttonValue.toString(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      onTap: callback
    );
  }
}
