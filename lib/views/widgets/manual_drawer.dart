import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/providers/database_provider.dart';
import 'package:quotes_cat_api_sqlite/views/favorite_screen/favorite_quotes_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.blueGrey, Colors.black],
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text(
                'Favorite Quotes',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
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
                  Navigator.of(context).pushNamed('quotes');
                }
              },
            ),
          ),
          // Add more list tiles for additional drawer items as needed
        ],
      ),
    );
  }
}
