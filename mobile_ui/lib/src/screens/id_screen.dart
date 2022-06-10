import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/src/controllers/data_controller.dart';
import 'package:mobile_ui/src/screens/user_screen.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({Key? key}) : super(key: key);

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idCon = TextEditingController();
  late final DataController dcController;
  String prompts = '';

  @override
  void initState() {
    dcController = DataController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: (size.height / 100) * 1.5),
        Center(
          child: Text('Identification',
              style:
                  GoogleFonts.actor(fontSize: 20, fontWeight: FontWeight.w600)),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.greenAccent,
            ),
          ),
        ),
        SizedBox(height: (size.height / 100) * 3),
        Container(
          height: (size.height / 100) * 20,
          child: Image.asset(
            'assets/images/g-chat.png',
          ),
        ),
        SizedBox(height: (size.height / 100) * 20),
        Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState?.validate();
            if (mounted) {
              setState(() {});
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                //Text(dc.error?.message ?? ''),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.actor(
                      fontSize: 20, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      hintText: 'Identification Number',
                      focusColor: Colors.amberAccent),
                  controller: _idCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your id';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: (size.height / 100) * 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 75),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          onPressed: (_formKey.currentState?.validate() ?? false)
              ? () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserScreen(_idCon.text.trim())));
                }
              : null,
          child: Text(
            'Check attendance',
            style: GoogleFonts.actor(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    ));
  }
}
