import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemBookWidget extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String image;

  ItemBookWidget({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
