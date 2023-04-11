import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../constants/transitions.dart';
import '../../layout/car_layout.dart';

class ConfirmScreen extends StatelessWidget {
  final String role;

  const ConfirmScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildText(
              role == 'wn4'
                  ? 'سيصل إليك الونش في اقرب وقت'
                  : role == 'fix'
                      ? 'نتمنى ان يتم تصليح العطل قريبا'
                      : role == 'cawtch'
                          ? 'نتمنى ان يتم استبدال الكاوتش قريبا'
                          : role == 'other'
                              ? '(:شكرا لاستخدامك تطبيقنا'
                              : '',
            ),
            Lottie.asset('assets/lotties/thanks.json'),
            InkWell(
              onTap: () =>
                  Navigator.push(context, CustomPageRoute1(child: CarLayout())),
              child: Text(
                'استخدام التطبيق مره اخرى!',
                style: GoogleFonts.cairo(fontSize: 20, color: Colors.pink),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text buildText(role) {
    return Text(
      role,
      style: GoogleFonts.cairo(fontSize: 22),
    );
  }
}
