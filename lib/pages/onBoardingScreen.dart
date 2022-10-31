import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:otaqu_devtest/common/constants.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/pages/splashScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = new PageController(
    keepPage: true,
  );
  int dots = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  dots = index;
                });
              },
              children: [boardingScreen1(), boardingScreen2()],
            ),
          ),
          dotsIndicator(dots)
        ],
      ),
    );
  }

  Padding dotsIndicator(int dots) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: DotsIndicator(
        dotsCount: 2,
        position: dots.toDouble(),
        decorator: DotsDecorator(
          color: abu,
          activeColor: pink,
        ),
      ),
    );
  }

  Column boardingScreen2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/OTAQU-1000X750-fit.png')),
        SizedBox(height: 50),
        Text(
          "Find Popular Destinations",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: hitamMuda),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 37),
          child: Text(
            "Temukan tempat wisata popular dengan Otaku.id",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: hitamMuda),
          ),
        ),
        SizedBox(height: 150),
        InkWell(
          onTap: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => SplashScreen()),
                (route) => false);
            await Keystore.save('prefs', 'log');
          },
          child: Container(
            width: 191,
            height: 47,
            decoration: BoxDecoration(
                color: pink, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "Get Started",
                textAlign: TextAlign.center,
                style: selectedButtonOnBoarding,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column boardingScreen1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/OTAQU-1000X750-fit.png')),
        SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Travel With Easy",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: hitamMuda),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 37),
          child: Text(
            "Beli tiket jadi lebih mudah dimana saja dan kapan saja dengan Otaqu.id",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: hitamMuda),
          ),
        ),
        SizedBox(height: 150),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => SplashScreen()),
                    (route) => false);
                await Keystore.save('prefs', 'log');
              },
              child: Container(
                width: 102,
                height: 37,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: pink)),
                child: Center(
                    child: Text(
                  "Skip",
                  style: unselectedButtonOnBoarding,
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                _pageController.animateToPage(1,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              child: Container(
                width: 102,
                height: 37,
                decoration: BoxDecoration(
                    color: pink, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: selectedButtonOnBoarding,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
