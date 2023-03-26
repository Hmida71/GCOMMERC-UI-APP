import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../animation/bouncing_effects.dart';
import '../constants.dart';
import '../data/data.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late PageController _scrollController;
  int currentIndex = 0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),
      statusBarColor: customColor,
    ));
    _scrollController = PageController();
    _scrollController.addListener(() {
      if (currentIndex == 0) {
        _autoScrollForward();
      } else if (currentIndex == (loginSwiperData.length - 1)) {
        _autoScrollbackward();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScrollForward();
    });
    super.initState();
  }

  _autoScrollForward() async {
    await Future.delayed(const Duration(seconds: 2));
    scheduleMicrotask(() {
      if (_scrollController.hasClients) {
        _scrollController.animateToPage(
          loginSwiperData.length,
          duration: const Duration(seconds: 6),
          curve: Curves.bounceIn,
        );
      }
    });
  }

  _autoScrollbackward() async {
    await Future.delayed(const Duration(seconds: 2));
    scheduleMicrotask(() async {
      if (_scrollController.hasClients) {
        _scrollController.animateToPage(
          0,
          duration: const Duration(seconds: 6),
          curve: Curves.linear,
        );
      }
    });
  }

  _autoAnumateTo(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateToPage(
        index,
        duration: const Duration(seconds: 2),
        curve: Curves.linearToEaseOut,
      );
    }
    // scheduleMicrotask(() async {
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      loginSwiperData.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _autoAnumateTo(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: 30,
                          height: 5,
                          color: currentIndex != index
                              ? const Color(0xff494949)
                              : customColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: w,
                  color: Colors.transparent,
                  child: const Text(
                    "Change Your\nPerspective ln Style",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: w,
                  color: Colors.transparent,
                  child: const Text(
                    "Change The Quality Of Your Appearance\nWith GCOMMERC Now !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.8,
                      color: Colors.white54,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: loginSwiperData.length,
                      onPageChanged: (i) {
                        setState(() {
                          currentIndex = i;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: w,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage(loginSwiperData[index]["image"]),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 60),
              ],
            ),
            Container(
              width: w,
              height: h / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xff212121).withOpacity(1),
                    const Color(0xff212121).withOpacity(0.8),
                    const Color(0xff212121).withOpacity(0.7),
                    const Color(0xff212121).withOpacity(0.5),
                    const Color(0xff212121).withOpacity(0.0),
                  ],
                ),
              ),
              child: Bouncing(
                onPress: () {
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: w * 0.9,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: customColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                      ),
                      child: const Text(
                        "Sign Up with Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
