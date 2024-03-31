// home_page.dart
import 'package:flutter/material.dart';
import 'package:quotes_cat_api_sqlite/models/category_model.dart';
import 'package:quotes_cat_api_sqlite/utils/data.dart';
import 'package:quotes_cat_api_sqlite/views/quote_page/detail_quote.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pinkAccent.shade200.withOpacity(0.7),
            Colors.deepPurple.shade300.withOpacity(0.9),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          centerTitle: true,
        ),
        drawer: const Drawer(),
        body: ListView.builder(
          itemCount: Data.catList.length,
          itemBuilder: (context, index) {
            final CategoryModel category = Data.catList[index];
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Colors.white10,
                elevation: 10,
                child: ListTile(
                  title: Text(
                    category.catName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailQuote(category: category.catName),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
