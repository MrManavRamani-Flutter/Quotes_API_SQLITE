import 'package:flutter/material.dart';
import 'package:quotes_cat_api_sqlite/helper/api_helper.dart';
import 'package:quotes_cat_api_sqlite/models/quote_model.dart';

class QuotesProvider with ChangeNotifier {
  late List<QuoteModel> _quotes = [];

  List<QuoteModel> get quotes => _quotes;

  Future<List<QuoteModel>> fetchQuotesByCategory(String category) async {
    try {
      final data = await ApiHelper().getQuotesByCategory(category);
      _quotes =
          data.map((quoteJson) => QuoteModel.fromJson(quoteJson)).toList();
      notifyListeners();
      return _quotes;
    } catch (error) {
      throw Exception('Failed to fetch quotes: $error');
    }
  }
}
