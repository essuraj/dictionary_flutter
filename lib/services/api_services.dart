import 'dart:convert';

import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/models/suggestion_response.dart';
import 'package:dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

/// Sends [text] to rapidapi to get suggestions.
///
/// Returns [SuggestionResponse] if all is well
Future<SuggestionResponse> checkSpelling(String text) async {
  var res = await http.post('https://jspell-checker.p.rapidapi.com/check',
      headers: {
        'Content-Type': 'application/json',
        "x-rapidapi-key": RAPID_API_KEY,
        "x-rapidapi-host": "jspell-checker.p.rapidapi.com"
      },
      body: jsonEncode({
        "language": "enUS",
        "fieldvalues": text,
        "config": {
          "forceUpperCase": false,
          "ignoreIrregularCaps": false,
          "ignoreFirstCaps": true,
          "ignoreNumbers": true,
          "ignoreUpper": false,
          "ignoreDouble": false,
          "ignoreWordsWithNumbers": true
        }
      }));
  print(res.body);
  return SuggestionResponse.fromJson(res.body);
}

/// Sends [text] to oxford dictionaries api to get definition of text.
///
/// Returns [DefinitionResponse] for the given text that is sent
Future<DefinitionResponse> getDefinition(String word) async {
  var res = await http.get(
    'https://od-api.oxforddictionaries.com/api/v2/entries/en-gb/${word}?fields=definitions&strictMatch=false',
    headers: {
      "Accept": "application/json",
      "app_id": OXFORD_API_KEY,
      "app_key": "41a7c270cea477074ce6bf18d8cd22a6"
    },
  );
  print(res.body);
  return DefinitionResponse.fromJson(res.body);
}
