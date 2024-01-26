import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchReservationData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Ошибка загрузки данных: $e');
  }
}
