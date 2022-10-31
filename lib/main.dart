import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaqu_devtest/blocs/init_page/init_page_bloc.dart';
import 'package:otaqu_devtest/pages/onBoardingScreen.dart';
import 'package:otaqu_devtest/pages/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => InitPageBloc()..add(InitPageMainEvent()),
          child: BlocBuilder<InitPageBloc, InitPageState>(
            builder: (context, state) {
              if (state is InitPageUnsaved) {
                return OnBoardingScreen();
              } else if (state is InitPageSaved) {
                return SplashScreen();
              }
              return SizedBox();
            },
          ),
        ));
  }
}
