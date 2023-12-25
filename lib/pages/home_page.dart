import 'package:flutter/material.dart';
import 'package:flutter_sqf_lite/db/db_admin.dart';
import 'package:flutter_sqf_lite/models/book_model.dart';
import 'package:flutter_sqf_lite/ui/utils/colors.dart';
import 'package:flutter_sqf_lite/ui/widgets/input_text_widget.dart';
import 'package:flutter_sqf_lite/ui/widgets/item_book_widget.dart';
import 'package:flutter_sqf_lite/ui/widgets/item_slider_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as Path;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];
  int idBook = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

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

  _showForm(bool add) {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black87.withOpacity(0.67),
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    add ? "Agregar libro" : "Editar Libro",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    width: 80,
                    height: 2.7,
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputTextFullWidget(
                    controller: _titleController,
                    hintText: "Titulo",
                    icon: "bx-bookmark",
                  ),
                  InputTextFullWidget(
                    controller: _authorController,
                    hintText: "Autor",
                    icon: "bx-user",
                  ),
                  InputTextFullWidget(
                    controller: _descriptionController,
                    hintText: "Description",
                    icon: "bx-list-ul",
                    maxLines: 3,
                  ),
                  InputTextFullWidget(
                    controller: _imageController,
                    hintText: "Portada",
                    icon: "bx-image-alt",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: GoogleFonts.poppins(color: Colors.white60),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          BookModel model = BookModel(
                            title: _titleController.text,
                            author: _authorController.text,
                            description: _descriptionController.text,
                            image: _imageController.text,
                          );
                          add
                              ? (DBAdmin.db.insertBook(model).then((value) {
                                  if (value > 0) {
                                    getBooks();
                                    Navigator.pop(context);
                                    _titleController.clear();
                                    _authorController.clear();
                                    _descriptionController.clear();
                                    _imageController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            const Color(0xff06d6a0),
                                        content: Expanded(
                                          child: Row(
                                            children: [
                                              Icon(Icons.check),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "Libro agregado correctamente",
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }))
                              : {
                                  model.id = idBook,
                                  DBAdmin.db.updateBook(model).then(
                                    (value) {
                                      if (value > 0) {
                                        getBooks();
                                        Navigator.pop(context);
                                        _titleController.clear();
                                        _authorController.clear();
                                        _descriptionController.clear();
                                        _imageController.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor:
                                                const Color(0xff06d6a0),
                                            content: Expanded(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.check_circle),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    "Libro editado correctamente",
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                };
                        },
                        child: Text(
                          "Aceptar",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF53649),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Eliminar libro",
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Text(
                "¿Estas seguro de eliminar este libro?",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar")),
                  ElevatedButton(
                    onPressed: () {
                      DBAdmin.db.deleteBook(id);
                      getBooks();
                      Navigator.pop(context);
                    },
                    child: Text("Aceptar"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          _titleController.clear();
          _authorController.clear();
          _imageController.clear();
          _descriptionController.clear();
          _showForm(true);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
                    children: books
                        .map<Widget>(
                          (BookModel e) => GestureDetector(
                            onLongPress: () {
                              idBook = e.id!;
                              _titleController.text = e.title;
                              _authorController.text = e.author;
                              _descriptionController.text = e.description;
                              _imageController.text = e.image;
                              _showForm(false);
                            },
                            child: ItemSliderWidget(
                              model: e,
                            ),
                          ),
                        )
                        .toList(),
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
                        (BookModel e) => GestureDetector(
                          onLongPress: () {
                            idBook = e.id!;
                            _titleController.text = e.title;
                            _authorController.text = e.author;
                            _descriptionController.text = e.description;
                            _imageController.text = e.image;
                            _showForm(false);
                          },
                          child: ItemBookWidget(
                            model: e,
                            onTap: () {
                              _showDeleteDialog(e.id!);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
