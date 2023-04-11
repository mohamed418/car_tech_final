import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/components.dart';
import '../../location/get_lat_long_address.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fixController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                shadeMask('نساعدك ازاي', GoogleFonts.cairo(fontSize: 25)),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: fixController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'قولنا نساعدك ازاي';
                    } else {
                      return null;
                    }
                  },
                  label: 'ايه المشكله',
                  prefix: Icons.car_rental,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetLatLongScreen(role: 'other',),
                          ));
                    } else {
                      //FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text('دووس'.toUpperCase(),
                      style:
                      GoogleFonts.cairo(color: Colors.white, fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
