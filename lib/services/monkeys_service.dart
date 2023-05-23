import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/monkey.dart';

class MonkeysService {
  Future<List<Monkey>> getAll() async {
    final monkeysResponse = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/jamesmontemagno/app-monkeys/master/MonkeysApp/monkeydata.json"));

    if (monkeysResponse.statusCode == 200) {
      var monkeys = parseMonkeys(monkeysResponse.body);
      return monkeys;
    } else {
      throw Exception('Failed to load monkeys');
    }
  }

  List<Monkey> parseMonkeys(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    try {
      return parsed.map<Monkey>((json) => Monkey.fromJson(json)).toList();
    } catch (e) {
      print("Exception in monkeys service parseMonkeys: $e");
      return [];
    }
  }
}
