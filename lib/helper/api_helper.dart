import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'https://api.api-ninjas.com/v1';
  static const String apiKey = 'f2uyTr1po7wEm7pZF9xMFw==MiWQtJDf8NGBzcZV';

  Future<List<dynamic>> getQuotesByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes?X-Api-Key=$apiKey&category=$category'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
