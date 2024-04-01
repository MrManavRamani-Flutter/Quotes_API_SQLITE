import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/models/quote_model.dart';
import 'package:quotes_cat_api_sqlite/providers/database_provider.dart';
import 'package:quotes_cat_api_sqlite/providers/quotes_provider.dart';

class DetailQuote extends StatefulWidget {
  final String category;

  const DetailQuote({Key? key, required this.category}) : super(key: key);

  @override
  DetailQuoteState createState() => DetailQuoteState();
}

class DetailQuoteState extends State<DetailQuote> {
  List<QuoteModel> _quotes = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    setState(() {
      _loading = true;
    });
    try {
      final quotes = await Provider.of<QuotesProvider>(context, listen: false)
          .fetchQuotesByCategory(widget.category);
      setState(() {
        _quotes = quotes;
        _loading = false;
      });
    } catch (error) {
      print('Error fetching quotes: $error');
      setState(() {
        _loading = false;
      });
    }
  }

  void _addToFavorites(QuoteModel quote) {
    Provider.of<DatabaseProvider>(context, listen: false).insertQuote({
      'quotes': quote.quote,
      'category': widget.category,
      'author': quote.author,
      'time': DateTime.now().toString(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote added to Favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _fetchQuotes,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _quotes.isEmpty
              ? const Center(child: Text('No quotes available'))
              : ListView.builder(
                  itemCount: _quotes.length,
                  itemBuilder: (context, index) {
                    var quote = _quotes[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"${quote.quote}"',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '- ${quote.author}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                _addToFavorites(quote);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.5)
                                      .withGreen(10),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
