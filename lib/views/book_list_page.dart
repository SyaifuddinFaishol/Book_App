import 'package:book_app/controllers/book_controllers.dart';
import 'package:book_app/views/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookControllers? bookControllers;

  @override
  void initState() {
    super.initState();
    bookControllers = Provider.of<BookControllers>(context, listen: false);
    bookControllers!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookControllers>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controllers, child) => Container(
          child: bookControllers!.bookList == null
              ? child
              : ListView.builder(
                  itemCount: bookControllers!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook =
                        bookControllers!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              isbn: currentBook.isbn13!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.network(
                            currentBook.image!,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentBook.title!,
                                  style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(currentBook.subtitle!),
                                  const SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        currentBook.price!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
