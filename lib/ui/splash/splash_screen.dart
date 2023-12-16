import 'package:flutter/material.dart';
import 'package:jogging_app/constant/spaces.dart';
import 'package:jogging_app/constant/text_style.dart';

import '../list_hiking/list_hiking_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/abcd.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          kVerticalSpace16,
          Text("Start your hike", style: AppStyles.commonTextStyle),
          kVerticalSpace16,
          _buildButton(context),
          kVerticalSpace16,
        ],
      ),
    );
  }

  Widget _buildButton(context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ListHikingScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.lightBlue,
        ),
        child: Center(
          child: Text(
            "Start",
            style: AppStyles.button01(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
