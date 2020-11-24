import 'package:http/http.dart' as http;

Future<http.Response> checkSpelling(String text) {
  return http.post('https://jspell-checker.p.rapidapi.com/check', body: {
    "language": "enUS",
    "fieldvalues": text,
  });
}
