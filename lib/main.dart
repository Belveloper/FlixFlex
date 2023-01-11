import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/views/Authetication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'views/movie_home_screen.dart';
import 'webServices/BlocObserver/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  await Hive.openBox('data');

  Widget home = AuthScreen();
  home =
      Hive.box('data').get('uid') != null ? const HomeScreen() : AuthScreen();

  runApp(MyApp(
    home,
  ));
}

class MyApp extends StatelessWidget {
  Widget home;
  MyApp(this.home);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()
        ..getMovies()
        ..getSeries()
        ..getTop5Movies()
        ..getTop5Series(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            backgroundColor: Colors.black,
            splash: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Flix",
                  style: TextStyle(
                      color: Color.fromARGB(255, 118, 132, 255),
                      fontSize: 50,
                      fontFamily: "Poppins-Bold",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Flex",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: "Poppins-Bold",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  ".",
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 132, 255),
                    fontSize: 50,
                    fontFamily: "Poppins-Bold",
                  ),
                ),
              ],
            ),
            nextScreen: home),
      ),
    );
  }
}
