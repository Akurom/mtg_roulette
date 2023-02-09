import 'package:flutter/material.dart';
import 'package:mtg_roulette/constants/colors.dart';
import 'package:mtg_roulette/constants/strings.dart';
import 'commons/count_widget.dart';


class CreationScreen extends StatefulWidget {
  const CreationScreen({Key? key}) : super(key: key);

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // players
            Text(Strings.creationPlayersNumber),
            // count widget limit 2:6
            CountWidget(defaultV:2, lowLimit: 2, highLimit: 6),
            // starting life total
            Text(Strings.creationStartingLife),
            CountWidget(defaultV: 20, lowLimit: 1, color: AppColors.pastelBlack,),
            // timer per player TODO
            //Text(Strings.creationTimePerPlayer),

            InkWell(
              child: Text(Strings.creationPlay, style: Theme.of(context).textTheme.headline2,),
              onTap: () {
                // navigate to GameScreen
              },
            ),
          ],
        ),
      ),
    );
  }
}
