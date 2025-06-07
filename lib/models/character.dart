// import 'dart:convert';

class Character {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int comicsCount;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.comicsCount,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final imageUrl = '${thumbnail['path']}.${thumbnail['extension']}';

    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: imageUrl.replaceAll('http:', 'https:'),
      comicsCount: json['comics']['available'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'comicsCount': comicsCount,
    };
  }
}
