import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/providers/database_provider.dart';
import 'package:quotes_cat_api_sqlite/providers/quotes_provider.dart';
import 'package:quotes_cat_api_sqlite/views/favorite_screen/favorite_quotes_screen.dart';
import 'package:quotes_cat_api_sqlite/views/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuotesProvider(),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'Quotes App',
        routes: {
          '/': (context) => const HomeScreen(),
          'quotes': (context) => const FavoriteScreen(),
        },
      ),
    );
  }
}
