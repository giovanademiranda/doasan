import 'dart:async';

import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.1;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: const Color(0xFFFF3737),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.23,
                        height: size.width * 0.23,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/2679/2679284.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        'Doasan\nSOROCABA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
