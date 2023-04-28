import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/sizes.dart';
import 'package:pawd/res/strings.dart';

import '../widgets/CustomNavigation.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;



  void _nextPage() {
    if (_currentPage == onboardPages.length - 1) {
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

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.fromLTRB(p_30, p_25, p_0, p_0),
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
                itemCount: onboardPages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(p_20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          onboardPages[index]['image'] ?? "",
                          height: p_200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: p_20),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomNavigationWidget(
                            pageCount: 3, // Replace with the number of pages
                            currentPageIndex: _currentPage,
                          ),
                        ),
                        SizedBox(height: p_20,),
                        Text(
                          onboardPages[index]['title'] ?? "",
                          style: TextStyle(
                              fontSize: p_30, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: p_20),
                        Text(
                          onboardPages[index]['description']?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: text_md, color: Colors.white),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: p_25,
                horizontal: p_30
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                    GestureDetector(
                      onTap: _prevPage,
                      child: Text('BACK'),
                    ),
                  if (_currentPage != onboardPages.length - 1)
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text('NEXT', style: TextStyle(
                        fontSize: text_md
                      ),),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: p_20, vertical: p_14),
                      ),
                    ),
                  if (_currentPage == onboardPages.length - 1)
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text('GET STARTED', style: TextStyle(
                          fontSize: text_md
                      )),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: p_20, vertical: p_14),
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



