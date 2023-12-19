import 'package:flutter/material.dart';
import 'package:flutter_sqf_lite/db/db_admin.dart';
import 'package:flutter_sqf_lite/models/book_model.dart';
import 'package:flutter_sqf_lite/ui/utils/colors.dart';
import 'package:flutter_sqf_lite/ui/widgets/item_book_widget.dart';
import 'package:flutter_sqf_lite/ui/widgets/item_slider_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks();
  }

  Future<void> getBooks() async {
    List<BookModel> dataFetch = await DBAdmin.db.getBooks();
    books = dataFetch;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Pablito Pantera",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: kPrimaryColor.withOpacity(0.45),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: kSecondaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(4, 4),
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Ver mas",
                      style: GoogleFonts.poppins(
                        color: Colors.white38,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(books.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemSliderWidget(
                              author: books[index].author,
                              description: books[index].description,
                              image: books[index].image,
                              title: books[index].title,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Best Seller",
                  style:
                      GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
                ),
                Column(
                  children: books
                      .map<Widget>(
                        (e) => ItemBookWidget(
                          author: e.author,
                          description: e.description,
                          image: e.image,
                          title: e.title,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
