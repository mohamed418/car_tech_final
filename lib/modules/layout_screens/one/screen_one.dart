import 'package:flutter/material.dart';
import 'package:test1/map/home_screen.dart';
import '../../../constants/transitions.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildContainer(
                size,
                // 'a1',
                'سوبر ماركت',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const homeScreen(
                      role: 'wn4',
                    ),
                  ),
                ),
              ),
              buildContainer(
                size,
                // 'a2',
                'ملابس',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const homeScreen(
                      role: 'cawtch',
                    ),
                  ),
                ),
              ),
              buildContainer(
                size,
                // 'a5',
                'كافيهات',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const homeScreen(
                      role: 'cawtch',
                    ),
                  ),
                ),
              ),
              buildContainer(
                size,
                // 'a4',
                'مطاعم',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const homeScreen(
                      role: 'cawtch',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildContainer(Size size, text, function) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            function();
          },
          child: Container(
              height: size.height * .3,
              width: size.width * .8,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                BorderRadius.all(Radius.circular(size.width * .1)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '$text',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              )),
        ),
        SizedBox(height: size.height * .02),
      ],
    );
  }
}
