import 'package:flutter/material.dart';
import 'package:mtg_roulette/models/dialer_model.dart';
import 'package:provider/provider.dart';

class DialerDigits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DialerModel>(builder: (context, dialer, child) {
      return Container(
        decoration: BoxDecoration(border: Border.all(width:3, color: Colors.white)),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              dialer.count.toString(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      );
    });
  }
}
