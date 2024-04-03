import 'package:flutter/material.dart';
import 'package:quotes_cat_api_sqlite/models/category_model.dart';
import 'package:quotes_cat_api_sqlite/utils/data.dart';
import 'package:quotes_cat_api_sqlite/views/quote_page/detail_quote.dart';
import 'package:quotes_cat_api_sqlite/views/widgets/manual_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late LinearGradient _backgroundGradient;

  @override
  void initState() {
    _backgroundGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black, Colors.blueGrey],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: _backgroundGradient,
        ),
        child: ListView.builder(
          itemCount: Data.catList.length,
          itemBuilder: (context, index) {
            final CategoryModel category = Data.catList[index];
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Colors.transparent,
                elevation: 10,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailQuote(category: category.catName),
                      ),
                    );
                  },
                  title: Text(
                    category.catName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
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
