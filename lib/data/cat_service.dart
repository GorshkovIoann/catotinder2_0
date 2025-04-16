import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/cat.dart';

class CatService {
  // URL с параметрами, включая API-ключ (замените его на свой, если потребуется)
  static const String apiUrl =
      'https://api.thecatapi.com/v1/images/search?has_breeds=1&api_key=live_NYFf8Gz7DAv5YHdih8vdWSHCjEKQsVePWieuZa1aSHO7VCOchCNya2bSgRkrsesZ';

  Future<Cat?> fetchRandomCat() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Fetched JSON: $data'); // Для отладки
      if (data is List && data.isNotEmpty) {
        try {
          return Cat.fromJson(data[0]);
        } catch (e) {
          print('Error parsing cat: $e');
        }
      } else {
        print('Received empty data');
      }
    } else {
      print('Failed to fetch cat: ${response.statusCode}');
    }
    return null;
  }
}
