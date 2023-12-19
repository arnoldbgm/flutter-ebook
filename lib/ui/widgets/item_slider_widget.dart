import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSliderWidget extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String image;

  ItemSliderWidget({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              height: 250,
              width: 170,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
