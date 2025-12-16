class ArticleEntity {
  final String id;
  final String designation;
  final num? prix;
  final int? qtestock;
  final String? imageart;

  ArticleEntity({
    required this.id,
    required this.designation,
    required this.prix,
    required this.qtestock,
    required this.imageart,
  });
}

class Article {
  final String id;
  final String designation;
  final double prix;
  final int qtestock;
  final String? imageart;
  final String? reference;
  final String? marque;

  Article({
    required this.id,
    required this.designation,
    required this.prix,
    required this.qtestock,
    this.imageart,
    this.reference,
    this.marque,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['_id'] ?? json['id'] ?? '',
      designation: json['designation'] ?? '',
      prix: (json['prix'] is int)
          ? (json['prix'] as int).toDouble()
          : (json['prix'] as num?)?.toDouble() ?? 0.0,
      qtestock: (json['qtestock'] as num?)?.toInt() ?? 0,
      imageart: json['imageart'],
      reference: json['reference'],
      marque: json['marque'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'designation': designation,
      'prix': prix,
      'qtestock': qtestock,
      'imageart': imageart,
      'reference': reference,
      'marque': marque,
    };
  }
}
