import 'package:flutter/material.dart';
import 'package:flutter_sqf_lite/models/book_model.dart';
import 'package:flutter_sqf_lite/ui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  BookModel book;

  DetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.0),
                    bottomRight: Radius.circular(28.0)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      book.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Titulo",
                    style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    book.title,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Author",
                    style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    book.author,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 100,
                    height: 3,
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    book.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
