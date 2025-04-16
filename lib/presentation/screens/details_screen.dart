import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/cat.dart';

class DetailsScreen extends StatelessWidget {
  final Cat cat;

  const DetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cat.breedName)),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: cat.url,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 20),
            Text(cat.breedName, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(cat.breedDescription, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
