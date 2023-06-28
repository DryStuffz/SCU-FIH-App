import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/image_string.dart';
import 'package:app/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: 0.45 * height,
              left: animate ? 0.43 * width : 0,
              child: const Image(image: AssetImage(logoLetters))),
          Positioned(
              top: 0.3*height,
              child: Container(
                  width: 0.44*width,
                  height: 0.5*height,
                  decoration: const BoxDecoration(color: blueGrey))),
          Positioned(
              top: 0.45 * height,
              left: 0.25 * width,
              child: const Image(image: AssetImage(logoF))),
        ],
      ),
      backgroundColor: blueGrey,
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 800));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const RootPage()));
  }
}
