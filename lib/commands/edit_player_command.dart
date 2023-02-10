
import 'package:mtg_roulette/commands/base_command.dart';
import 'package:mtg_roulette/models/player_model.dart';
import 'package:flutter/material.dart';


class EditPlayerCommand extends BaseCommand {


  Future<bool> run(PlayerModel player, String name, Color color) async {
    print(player.color);
    print(color);
    player.editPreferences(name, color);
    return true;
  }
}