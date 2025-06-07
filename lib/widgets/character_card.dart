import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: character.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: Icon(Icons.person),
            ),
            errorWidget: (context, url, error) => Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: Icon(Icons.error),
            ),
          ),
        ),
        title: Text(
          character.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          character.description.isEmpty
              ? 'No description available'
              : character.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onFavoriteToggle != null
            ? IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: onFavoriteToggle,
              )
            : Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
