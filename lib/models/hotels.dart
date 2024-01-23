import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchHotelData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/75000507-da9a-43f8-a618-df698ea7176d'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Ошибка загрузки данных: $e');
  }
}
