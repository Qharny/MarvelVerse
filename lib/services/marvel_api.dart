import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class MarvelAPI {
  static const String _baseUrl = 'https://gateway.marvel.com/v1/public';
  static const String _apiKey = '92026bbc665af72a36b3c35d47975baa';
  static const String _hash = '83cfdf3c98396891fbcb258b83e347fc';
  static const String _timestamp = '1234';

  static Future<List<Character>> getCharacters({
    int limit = 20,
    int offset = 0,
  }) async {
    final url =
        '$_baseUrl/characters?ts=$_timestamp&apikey=$_apiKey&hash=$_hash&limit=$limit&offset=$offset';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['data']['results'];

        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Character>> searchCharacters(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        '$_baseUrl/characters?ts=$_timestamp&apikey=$_apiKey&hash=$_hash&nameStartsWith=$encodedQuery&limit=20';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['data']['results'];

        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search characters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }
}
