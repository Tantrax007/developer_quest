import 'dart:async';

import 'package:dev_rpg/src/about_screen.dart';
import 'package:dev_rpg/src/code_chomper/code_chomper.dart';
import 'package:dev_rpg/src/game_screen.dart';
import 'package:dev_rpg/src/shared_state/game/world.dart';
import 'package:dev_rpg/src/shared_state/user.dart';
import 'package:dev_rpg/src/style_sphinx/axis_questions.dart';
import 'package:dev_rpg/src/style_sphinx/flex_questions.dart';
import 'package:dev_rpg/src/style_sphinx/kittens.dart';
import 'package:dev_rpg/src/style_sphinx/sphinx_image.dart';
import 'package:dev_rpg/src/style_sphinx/sphinx_screen.dart';
import 'package:dev_rpg/src/welcome_screen.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Don't prune the Flare cache, keep loaded Flare files warm and ready
  // to be re-displayed.
  FlareCache.doesPrune = false;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final World world = World();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => User()),
          ChangeNotifierProvider.value(value: world),
          ChangeNotifierProvider.value(value: world.characterPool),
          ChangeNotifierProvider.value(value: world.taskPool),
          ChangeNotifierProvider.value(value: world.company),
          ChangeNotifierProvider.value(value: world.company.users),
          ChangeNotifierProvider.value(value: world.company.joy),
          ChangeNotifierProvider.value(value: world.company.coin),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.orange,
              canvasColor: Colors.transparent),
          routes: {
            '/': (_) => WelcomeScreen(),
            '/gameloop': (_) => GameScreen(),
            '/about': (_) => AboutScreen(),
            CodeChomper.miniGameRouteName: (context) {
              String filename =
                  ModalRoute.of(context)?.settings.arguments as String;
              return CodeChomper(filename);
            },
            SphinxScreen.miniGameRouteName: (_) => const SphinxScreen(),
            SphinxScreen.fullGameRouteName: (_) =>
                const SphinxScreen(fullGame: true),
            ColumnQuestion.routeName: (_) => ColumnQuestion(),
            RowQuestion.routeName: (_) => RowQuestion(),
            StackQuestion.routeName: (_) => StackQuestion(),
            MainAxisCenterQuestion.routeName: (_) => MainAxisCenterQuestion(),
            MainAxisSpaceAroundQuestion.routeName: (_) =>
                MainAxisSpaceAroundQuestion(),
            MainAxisSpaceBetweenQuestion.routeName: (_) =>
                MainAxisSpaceBetweenQuestion(),
            MainAxisStartQuestion.routeName: (_) => MainAxisStartQuestion(),
            MainAxisEndQuestion.routeName: (_) => MainAxisEndQuestion(),
            MainAxisSpaceEvenlyQuestion.routeName: (_) =>
                MainAxisSpaceEvenlyQuestion(),
            RowMainAxisEndQuestion.routeName: (_) => RowMainAxisEndQuestion(),
            RowMainAxisStartQuestion.routeName: (_) =>
                RowMainAxisStartQuestion(),
            RowMainAxisSpaceBetween.routeName: (_) => RowMainAxisSpaceBetween(),
          },
        ));
  }

  @override
  void initState() {
    // Schedule a microtask that warms up the image cache with all of the style
    // sphinx images. This will run after the build method is executed, but
    // before the style sphinx is displayed.
    scheduleMicrotask(() {
      precacheImage(SphinxScreen.pyramid, context);
      precacheImage(SphinxScreen.background, context);
      precacheImage(SphinxImage.provider, context);
      precacheImage(SphinxWithoutGlassesImage.provider, context);
      precacheImage(SphinxGlassesImage.provider, context);
      precacheImage(KittyBed.redProvider, context);
      precacheImage(KittyBed.greenProvider, context);
      precacheImage(Kitty.orangeProvider, context);
      precacheImage(Kitty.yellowProvider, context);
    });
    super.initState();
  }

  @override
  void dispose() {
    world.dispose();
    super.dispose();
  }
}
