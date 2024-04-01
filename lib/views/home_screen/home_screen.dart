// home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/models/category_model.dart';
import 'package:quotes_cat_api_sqlite/providers/database_provider.dart';
import 'package:quotes_cat_api_sqlite/utils/data.dart';
import 'package:quotes_cat_api_sqlite/views/favorite_screen/favorite_quotes_screen.dart';
import 'package:quotes_cat_api_sqlite/views/quote_page/detail_quote.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Favorite Quotes'),
              onTap: () async {
                Navigator.pop(context); // Close the drawer
                final databaseProvider =
                    Provider.of<DatabaseProvider>(context, listen: false);
                if (databaseProvider.isInitialized) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()),
                  );
                } else {
                  // Wait for database initialization
                  await databaseProvider.initialize();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
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
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          );
        },
      ),
    );
  }
}
