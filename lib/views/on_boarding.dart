import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pawd/widgets/OnBoardingSwipe.dart';
import 'package:pawd/blocs/onboard_bloc.dart';
import 'package:pawd/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to MyApp',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/onboard1.svg'
    },
    {
      'title': 'Easy to Use',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/onboard2.svg'    },
    {
      'title': 'Get Started',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/onboard3.svg'
    },
  ];

  void _nextPage() {
    if (_currentPage == _pages.length - 1) {
      // last page reached, show Get Started button
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/welcome');
                  },
                    child : Text(
                  "SKIP",
                  style: Theme.of(context).textTheme.bodyText2,
                ))
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _pages[index]['image'] ?? "",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 40),
                        Text(
                          _pages[index]['title'] ?? "",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          _pages[index]['description']?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 25,
                horizontal: 30
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                    GestureDetector(
                      onTap: _prevPage,
                      child: Text('BACK'),
                    ),
                  if (_currentPage != _pages.length - 1)
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text('NEXT', style: TextStyle(
                        fontSize: 22
                      ),),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                      ),
                    ),
                  if (_currentPage == _pages.length - 1)
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text('GET STARTED', style: TextStyle(
                          fontSize: 22
                      )),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


