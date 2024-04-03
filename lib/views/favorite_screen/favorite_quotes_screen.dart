import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/providers/database_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Map<String, dynamic>>> _favoriteQuotesFuture;

  @override
  void initState() {
    super.initState();
    _favoriteQuotesFuture = _fetchFavoriteQuotes();
  }

  Future<List<Map<String, dynamic>>> _fetchFavoriteQuotes() async {
    try {
      return Provider.of<DatabaseProvider>(context, listen: false)
          .getFavoriteQuotes();
    } catch (error) {
      // Handle error appropriately
      print('Error fetching favorite quotes: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
        centerTitle: true,
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.black],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _favoriteQuotesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final quotes = snapshot.data ?? [];

              if (quotes.isEmpty) {
                return const Center(
                  child: Text(
                    'No favorite quotes available.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }

              return ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return _buildQuoteCard(context, quotes[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, Map<String, dynamic> quote) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(
                "${quote['id']}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote['quotes'],
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Category: ${quote['category']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Author: ${quote['author']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Time: ${quote['time']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteQuote(context, quote['id']);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteQuote(BuildContext context, int id) async {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    await databaseProvider.deleteQuote(id);
    setState(() {
      _favoriteQuotesFuture = _fetchFavoriteQuotes();
    });
  }
}
