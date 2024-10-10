import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final input = await fetchInput();
  final results = processQueries(input['data'], input['query']);
  await sendOutput(results, input['token']);
}

Future<Map<String, dynamic>> fetchInput() async {
  final response = await http
      .get(Uri.parse('https://test-share.shub.edu.vn/api/intern-test/input'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load input');
  }
}

List<int> processQueries(List<dynamic> data, List<dynamic> queries) {
  List<int> intData = data.cast<int>();
  List<int> typeOneSum = [0];
  List<int> typeTwoSum = [0];

  for (int i = 0; i < intData.length; i++) {
    typeOneSum.add(typeOneSum.last + intData[i]);
    typeTwoSum.add(typeTwoSum.last + (i % 2 == 0 ? intData[i] : -intData[i]));
  }

  List<int> results = [];

  for (var query in queries) {
    int l = query['range'][0];
    int r = query['range'][1];

    if (query['type'] == '1') {
      results.add(typeOneSum[r + 1] - typeOneSum[l]);
    } else {
      results.add(typeTwoSum[r + 1] - typeTwoSum[l]);
    }
  }

  return results;
}

Future<void> sendOutput(List<int> results, String token) async {
  final response = await http.post(
    Uri.parse('https://test-share.shub.edu.vn/api/intern-test/output'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(results),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to send output');
  }
}
