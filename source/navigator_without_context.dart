import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {

  setupLocator(); // initailize your setup here

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GetIt locator = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          navigatorKey: locator<AppNavigator>().navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case "/":
                    return MaterialPageRoute(
                        settings: RouteSettings(name: settings.name, arguments: settings.arguments),
                        builder: (BuildContext context) => const HomePage());
                default:
                    return MaterialPageRoute(
                        settings: RouteSettings(name: settings.name, arguments: settings.arguments),
                        builder: (BuildContext context) => const HomePage());
          },
        );
  }
}



class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> toNamed(String name, {dynamic argument}) {
    return navigatorKey.currentState!.pushNamed(name, arguments: argument);
  }

  Future<dynamic> offNamed(String name, {dynamic argument}) {
    return navigatorKey.currentState!.popAndPushNamed(name,arguments: argument);
  }

  void pop([dynamic result]) {
    navigatorKey.currentState!.pop(result);
  }

  void offAllToNamed(String name, {dynamic argument}) {
    navigatorKey.currentState!.popUntil((route) => route.settings.name == "/");
    toNamed(name, argument: argument);
  }
}

GetIt locator = GetIt.instance;
// initialize method this should be called before the app render
void setupLocator() {
  locator.registerLazySingleton(() => AppNavigator());
}