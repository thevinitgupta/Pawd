import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnBoardingSwipe extends StatelessWidget {
  const OnBoardingSwipe({Key? key}) : super(key: key);

  Widget buildCarousel() {
    final List<List<String>> imageList = [
      [
        "assets/onboard1.svg",
        "Manage your tasks",
        "You can easily manage all of your daily tasks in DoMe for free"
      ],
      [
        "assets/onboard2.svg",
        "Create daily routine",
        "In Uptodo  you can create your personalized routine to stay productive"
      ],
      [
        "assets/onboard3.svg",
        "Organize your tasks",
        "You can organize your daily tasks by adding your tasks into separate categories"
      ],
    ];
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        aspectRatio: 4 / 3,
        viewportFraction: 1,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: imageList.map((imageData) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      imageData[0],
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    Text(
                      imageData[1],
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      imageData[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildCarousel(),
    );;
  }
}

