import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mtg_roulette/models/game_model.dart';
import 'package:mtg_roulette/models/app_model.dart';
import 'package:mtg_roulette/models/menu_model.dart';
import 'package:provider/provider.dart';

import 'package:mtg_roulette/views/layouts/layouts.dart';
import 'package:mtg_roulette/views/screens/screens.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:mtg_roulette/commands/base_command.dart' as Commands;
import 'package:mtg_roulette/const/color_constants.dart';
import 'tools/tools.dart';


void main() {
  // ------
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // ------

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext _) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        ChangeNotifierProvider<GameModel>(create: (c) => GameModel()),
        ChangeNotifierProvider<MenuModel>(create: (c) => MenuModel()),
      ],
      child: Builder(builder: (context) {
        Commands.init(context);         // todo UNDERSTAND !!!
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // ----------- theme data
          theme: new ThemeData(       // todo load from AppModel
            //scaffoldBackgroundColor: ColorConstants.black,
            scaffoldBackgroundColor: ColorConstants.white,
            textTheme: TextTheme(
              displayLarge: GoogleFonts.roboto(fontSize: 92.0, color: ColorConstants.main),
              displayMedium: GoogleFonts.roboto(fontSize: 44.0, color: ColorConstants.main),
              displaySmall: GoogleFonts.roboto(fontSize: 24.0, color: ColorConstants.main),
              labelSmall: GoogleFonts.roboto(color: ColorConstants.main),
              headlineSmall: GoogleFonts.roboto(color: ColorConstants.main),
            ),
          ),
          // ----------- routes
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/creation': (context) => CreationScreen(),
            '/two': (context) => const TwoPlayers(),
            '/three': (context) => const ThreePlayers(),
            '/four': (context) => const FourPlayers(),
            '/five': (context) => const FivePlayers(),
            '/six': (context) => const SixPlayers(),
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
            : CircularProgressIndicator(), // todo show splash screen here instead of progress indicator
      ),
    );
  }
}



