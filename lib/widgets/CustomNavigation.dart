import 'package:flutter/material.dart';

import '../res/sizes.dart';

class CustomNavigationWidget extends StatelessWidget {
  final int pageCount;
  final int currentPageIndex;

  const CustomNavigationWidget({
    Key? key,
    required this.pageCount,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
            (index) =>
            Padding(
              padding: const EdgeInsets.all(p_8),
              child: Container(
                width: p_10,
                height: p_10,
                decoration: BoxDecoration(
                  color: index == currentPageIndex ? Colors.white : Colors.grey,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(p_50),
                    right: Radius.circular(p_50),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}