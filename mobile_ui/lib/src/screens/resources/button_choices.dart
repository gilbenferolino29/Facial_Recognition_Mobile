import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Buttons
AnimatedOpacity accountsButton(buttonChoice, _pageController) {
  return AnimatedOpacity(
    duration: Duration(milliseconds: 350),
    opacity: buttonChoice == 0 ? 1 : 0.5,
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: buttonChoice == 0 ? Colors.white : Colors.black12,
          backgroundColor: buttonChoice == 0 ? Colors.green : Colors.grey,
          side: BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 55),
        ),
        onPressed: () {
          _pageController.jumpToPage(0);
          buttonChoice = 0;
        },
        child: Text('Accounts', style: GoogleFonts.inter(fontSize: 17))),
  );
}

AnimatedOpacity attendanceButton(buttonChoice, _pageController) {
  return AnimatedOpacity(
    duration: Duration(milliseconds: 600),
    opacity: buttonChoice == 1 ? 1 : 0.5,
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: buttonChoice == 1 ? Colors.white : Colors.black12,
          backgroundColor: buttonChoice == 1 ? Colors.green : Colors.grey,
          side: BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        ),
        onPressed: () {
          _pageController.jumpToPage(1);
        },
        child: Text('Attendances', style: GoogleFonts.inter(fontSize: 17))),
  );
}
