import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/character.dart';
import '../services/bookmark_manager.dart';
import '../widgets/character_card.dart';
import 'character_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Character> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await BookmarkManager.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks'), elevation: 0),
      body: _favorites.isEmpty
          ? _buildEmptyBookmarks()
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final character = _favorites[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 30.0,
                    child: FadeInAnimation(
                      child: CharacterCard(
                        character: character,
                        isFavorite: true,
                        onTap: () => _navigateToCharacterDetail(character),
                        onFavoriteToggle: () => _removeFavorite(character),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyBookmarks() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No Bookmarks Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start exploring and bookmark your favorite characters!',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToCharacterDetail(Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(character: character),
      ),
    ).then((_) => _loadFavorites());
  }

  void _removeFavorite(Character character) async {
    await BookmarkManager.removeFavorite(character);
    _loadFavorites();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${character.name} from bookmarks'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
