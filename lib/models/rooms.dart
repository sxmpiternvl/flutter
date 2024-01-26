import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchRoomsData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/157ea342-a8a3-4e00-a8e6-a87d170aa0a2'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Ошибка загрузки данных: $e');
  }
}
