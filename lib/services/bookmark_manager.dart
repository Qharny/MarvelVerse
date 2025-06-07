import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class BookmarkManager {
  static const String _favoritesKey = 'favorites';

  static Future<List<Character>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

      return favoritesJson
          .map((jsonString) => Character.fromJson(json.decode(jsonString)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> addFavorite(Character character) async {
    try {
      final favorites = await getFavorites();

      if (!favorites.any((char) => char.id == character.id)) {
        favorites.add(character);
        await _saveFavorites(favorites);
      }
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  static Future<void> removeFavorite(Character character) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((char) => char.id == character.id);
      await _saveFavorites(favorites);
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  static Future<void> _saveFavorites(List<Character> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = favorites
          .map((character) => json.encode(character.toJson()))
          .toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }
}
