// detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_cat_api_sqlite/models/quote_model.dart';
import 'package:quotes_cat_api_sqlite/providers/quotes_provider.dart';

class DetailQuote extends StatefulWidget {
  final String category;

  const DetailQuote({Key? key, required this.category}) : super(key: key);

  @override
  _DetailQuoteState createState() => _DetailQuoteState();
}

class _DetailQuoteState extends State<DetailQuote> {
  List<QuoteModel> _quotes = [];

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    try {
      final quotes = await Provider.of<QuotesProvider>(context, listen: false)
          .fetchQuotesByCategory(widget.category);
      setState(() {
        _quotes = quotes;
      });
    } catch (error) {
      print('Error fetching quotes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: _quotes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _quotes.length,
              itemBuilder: (context, index) {
                var quote = _quotes[index].quote;
                var author = _quotes[index].author;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"$quote"',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- $author',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchQuotes,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
