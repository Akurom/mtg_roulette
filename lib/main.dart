import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:mtg_roulette/models/app_model.dart';

import 'package:mtg_roulette/views/creation_screen.dart';
import 'package:mtg_roulette/views/game_screen.dart';
import 'package:mtg_roulette/views/stats_screen.dart';

import 'package:mtg_roulette/commands/base_command.dart' as Commands;
import 'package:mtg_roulette/constants/colors.dart';





void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext _) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        //ChangeNotifierProvider<LightModel>(create: (c) => LightModel()),  // todo set in sky section init ther and link to basecommand
      ],
      child: Builder(builder: (context) {
        Commands.init(context);         // todo UNDERSTAND !!!
        return MaterialApp(
          // ----------- theme data
          theme: new ThemeData(       // todo load from AppModel
            scaffoldBackgroundColor: AppColors.white,
            accentColor: Colors.grey,
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Georgia',
              //fontSizeFactor: 1.4,
            ),
          ),
          // ----------- routes
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/creation': (context) => const CreationScreen(),
            '/game': (context) => const GameScreen(),
            '/stats': (context) => const StatsScreen(),
          },
          //onGenerateRoute: onGenerateRoute, // todo animation on routing
          home: SplashScreen(),
        );
      }),
    );
  }
}


// ============================ SPLASH SCREEN ==================================
class SplashScreen extends StatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  bool _appLoaded = false;

  // ------------------ APP INITIALISATION ---------------------
  @override
  void initState() {
    /// Load appModel first, to fetch the appTheme ASAP
    context.read<AppModel>().load().then((value) async {
      SystemChrome.setEnabledSystemUIOverlays([]);
      // init command ?
      setState(() => _appLoaded = true);
      return true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _appLoaded
            ? CreationScreen()
            : CircularProgressIndicator(), //show splash screen here instead of progress indicator
      ),
    );
  }
}



