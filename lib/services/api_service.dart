import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/giveaway.dart';

class ApiService {
  static const String _baseUrl = 'https://www.gamerpower.com/api/giveaways';

  Future<List<Giveaway>> fetchGiveaways() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((item) => Giveaway.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load giveaways: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
