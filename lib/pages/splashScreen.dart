import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaqu_devtest/blocs/post_login/post_login_bloc.dart';
import 'package:otaqu_devtest/pages/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostLoginBloc()..add(PostLoginMainEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Builder(builder: (context) {
          return BlocBuilder<PostLoginBloc, PostLoginState>(
            builder: (context, state) {
              if (state is PostLoginLoaded) {
                Future.delayed(
                    Duration(
                      milliseconds: 1000,
                    ), () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(
                          seconds: 1,
                        ),
                        pageBuilder: (context, animation, animationTime) {
                          return HomeScreen();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ));
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'assets/logo-otaqu.png',
                        width: 330,
                      )),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Powered by : Otaqu.id',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
