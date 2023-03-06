import 'package:flutter/material.dart';
import 'package:mtg_roulette/commands/player/set_commander_watcher_command.dart';
import 'package:mtg_roulette/commands/player/modify_commander_damage_command.dart';
import 'package:mtg_roulette/commands/player/toggle_highlight_player_command.dart';
import 'package:mtg_roulette/const/color_constants.dart';
import 'package:mtg_roulette/const/size_constants.dart';
import 'package:mtg_roulette/models/commander_damage_model.dart';
import 'package:mtg_roulette/models/counter_model.dart';
import 'package:mtg_roulette/models/game_model.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:mtg_roulette/tools/tools.dart';
import 'package:provider/provider.dart';

class CommanderDamageBar extends StatelessWidget {
  final PlayerModel currentPlayer;
  final bool tiny;

  const CommanderDamageBar({required this.currentPlayer, this.tiny = false});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(bottom: screenWidth(context) * SizeConstants.standardPaddingRatio),
      width: (screenWidth(context) * SizeConstants.commanderTagWidth).hypotenuse * (tiny ? 0.90 : 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (CommanderDamageModel cmdD in currentPlayer.commanderDamages)
            CommanderDamageTag(
              player: currentPlayer,
              tiny: tiny,
              commanderDamageModel: cmdD,
              counterModel: currentPlayer.lifeCounter,
            ),
          // pass player.counter ?
        ],
      ),
    );
  }
}

class CommanderDamageTag extends StatefulWidget {
  final PlayerModel player;
  final CommanderDamageModel commanderDamageModel;
  final CounterModel counterModel;
  final bool tiny;

  const CommanderDamageTag({required this.player, this.tiny = false, required this.commanderDamageModel, required this.counterModel});

  State<CommanderDamageTag> createState() => _CommanderDamageTagState();
}

class _CommanderDamageTagState extends State<CommanderDamageTag> {

  late int initialCount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommanderDamageModel>.value(value: widget.commanderDamageModel),
        ChangeNotifierProvider<CounterModel>.value(value: widget.counterModel),
      ],
      child: Builder(builder: (context) {


        CounterModel counter = context.watch<CounterModel>();
        if (widget.commanderDamageModel.isWatching) {
          ModifyCommanderDamageCommand().run(widget.commanderDamageModel, initialCount - counter.count);
          initialCount = widget.counterModel.count;
        }

        return RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: Container(
            width: screenWidth(context) * SizeConstants.commanderTagWidth * (widget.tiny ? 0.90 : 1),
            height: screenWidth(context) * SizeConstants.commanderTagWidth * (widget.tiny ? 0.90 : 1),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.main, width: 3.0),
              color: widget.commanderDamageModel.fromPlayer.color,
            ),
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360),
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: FittedBox(
                  child: InkWell(
                    child: Consumer<CounterModel>(
                    //child: Consumer<CommanderDamageModel>(
                      builder: (context, counter, child) {
                        return Text(widget.commanderDamageModel.totalDamage.toString(),
                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall!);
                      },
                    ),
                    onTap: () {
                      initialCount = context.read<CounterModel>().count;
                      SetCommanderWatchCommand().run(widget.player, widget.commanderDamageModel, !widget.commanderDamageModel.isWatching);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
