import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqf_lite/ui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputTextFullWidget extends StatelessWidget {
  String hintText;
  String icon;
  int? maxLines;
  TextEditingController controller;

  InputTextFullWidget(
      {required this.hintText,
      required this.icon,
      required this.controller,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      child: (TextField(
        controller: controller,
        style: GoogleFonts.poppins(color: Colors.white),
        cursorColor: kSecondaryColor,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: 13,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xff2A2D37),
          prefixIcon: SvgPicture.asset(
            'assets/images/$icon.svg',
            color: Colors.white54,
            fit: BoxFit.scaleDown,
          ),
        ),
      )),
    );
  }
}
