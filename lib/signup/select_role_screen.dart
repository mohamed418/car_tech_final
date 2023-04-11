// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import '../../constants/colors.dart';
// import '../../constants/components.dart';
// import '../../constants/transitions.dart';
//
// class SelectRoleScreen extends StatefulWidget {
//   @override
//   State<SelectRoleScreen> createState() => _SelectRoleScreenState();
// }
//
// class _SelectRoleScreenState extends State<SelectRoleScreen> {
//   bool businessButtonIsPressed = false;
//
//   bool customerButtonIsPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'حابب تستخدم فرزه بأي صفه!',
//                       style: GoogleFonts.cairo(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: defaultColor),
//                     ),
//                     SizedBox(height: height(context, .02)),
//                     SizedBox(
//                       width: width(context, .9),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '- اختار تاجر لو انت تاجر وحابب تضيف منتجات',
//                             style: GoogleFonts.cairo(fontSize: 20),
//                           ),
//                           Text(
//                             '- اما لو انت مستخدم عادي حابب تشتري من غير ما تبيع منتجات اختار مستخدم',
//                             style: GoogleFonts.cairo(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height(context, .1)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'تاجر',
//                           style: GoogleFonts.cairo(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               pressBusinessButton();
//                             });
//                           },
//                           child: Container(
//                             width: 250,
//                             decoration: BoxDecoration(
//                               gradient:
//                                   businessButtonIsPressed ? gradient : null,
//                               color: secondDefaultColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Lottie.asset('assets/lotties/business.json'),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: height(context, .1)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'مستخدم',
//                           style: GoogleFonts.cairo(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               pressCustomerButton();
//                             });
//                           },
//                           child: Container(
//                             width: 250,
//                             decoration: BoxDecoration(
//                               gradient:
//                                   customerButtonIsPressed ? gradient : null,
//                               color: secondDefaultColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Lottie.asset('assets/lotties/customer.json'),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: height(context, .02)),
//                     buildBelowButtons(context, () {
//                       genderNextButton(context);
//                     }, backButton: false),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void pressBusinessButton() {
//     businessButtonIsPressed = true;
//     customerButtonIsPressed = false;
//     debugPrint('business');
//   }
//
//   void pressCustomerButton() {
//     businessButtonIsPressed = false;
//     customerButtonIsPressed = true;
//     debugPrint('customer');
//   }
//
//   dynamic genderNextButton(context) {
//     businessButtonIsPressed || customerButtonIsPressed
//         ? Navigator.push(
//             context,
//             CustomPageRoute(
//                 child: SignUpScreen(
//                   isSeller: businessButtonIsPressed,
//                 ),
//                 direction: AxisDirection.right))
//         : buildSnackBar('حدد انت تاجر ولا مستخدم الاول', context, 3);
//   }
//
//   Row buildBelowButtons(BuildContext context, Function function,
//       {bool backButton = true}) {
//     return Row(
//       children: [
//         backButton
//             ? Container(
//                 decoration: BoxDecoration(
//                     color: businessButtonIsPressed || customerButtonIsPressed
//                         ? secondDefaultColor
//                         : Colors.blueGrey,
//                     shape: BoxShape.circle),
//                 child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: black,
//                       size: 30,
//                     )),
//               )
//             : Container(),
//         const Spacer(),
//         SizedBox(
//           height: height(context, .06),
//           width: width(context, .35),
//           child: ElevatedButton(
//               onPressed: () => function(),
//               style: ButtonStyle(
//                 backgroundColor:
//                     businessButtonIsPressed || customerButtonIsPressed
//                         ? MaterialStateProperty.all(defaultColor)
//                         : MaterialStateProperty.all(Colors.blueGrey),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'التالي',
//                     style: GoogleFonts.cairo(
//                         fontWeight: FontWeight.w600,
//                         color: black,
//                         fontSize: 20),
//                   ),
//                   const SizedBox(width: 7),
//                   Icon(
//                     Icons.arrow_forward_ios_sharp,
//                     color: black,
//                   )
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
// }
