// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterways/LoginFlow/login.dart';
import 'package:waterways/LoginFlow/sign_up_as.dart';

class LoginOrCreate extends StatelessWidget {
  const LoginOrCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(children: [
            SizedBox(height: 110),
            Image.asset(
              'assets/WaterWaysIconBig.png',
              height: 180,
              width: 430,
            ),
            SizedBox(height: 45),
            Text(
              'Test the waters',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
                color: const Color(0xFF313144),
              ),
            ),
            SizedBox(height: 11),
            Text(
              'Now your water supply is in one place and always under control',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
                fontSize: 17.0,
                color: const Color(0xFF313144),
              ),
            ),
            SizedBox(height: 75),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(353, 56),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                'Log In',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 14),
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF007AFF),
                side: BorderSide(color: Color(0xFF007AFF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(353, 56),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpAs()),
                );
              },
              child: Text(
                'Create Account',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
