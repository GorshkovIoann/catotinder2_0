class Cat {
  final String id;
  final String url;
  final String breedName;
  final String breedDescription;

  Cat({
    required this.id,
    required this.url,
    required this.breedName,
    required this.breedDescription,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'];
    if (breeds == null || (breeds is List && breeds.isEmpty)) {
      throw Exception('No breed data available');
    }
    final breed = breeds[0];
    return Cat(
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
      breedName: breed['name'] as String? ?? 'Unknown breed',
      breedDescription:
          breed['description'] as String? ?? 'No description available',
    );
  }
}
