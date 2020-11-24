import 'dart:convert';

import 'package:dictionary/models/definition_response.dart';
import 'package:dictionary/models/suggestion_response.dart';
import 'package:dictionary/pages/definition_page.dart';
import 'package:dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

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
  return SuggestionResponse.fromJson(res.body);
}

var def = """{
  "id": "ace",
  "metadata": {
    "operation": "retrieve",
    "provider": "Oxford University Press",
    "schema": "RetrieveEntry"
  },
  "results": [
    {
      "id": "ace",
      "language": "en-gb",
      "lexicalEntries": [
        {
          "entries": [
            {
              "homographNumber": "100",
              "senses": [
                {
                  "definitions": [
                    "a playing card with a single spot on it, ranked as the highest card in its suit in most card games"
                  ],
                  "id": "m_en_gbus0005680.006"
                },
                {
                  "definitions": [
                    "a person who excels at a particular sport or other activity"
                  ],
                  "id": "m_en_gbus0005680.010",
                  "subsenses": [
                    {
                      "definitions": [
                        "a pilot who has shot down many enemy aircraft"
                      ],
                      "id": "m_en_gbus0005680.011"
                    }
                  ]
                },
                {
                  "definitions": [
                    "(in tennis and similar games) a service that an opponent is unable to return and thus wins a point"
                  ],
                  "id": "m_en_gbus0005680.013",
                  "subsenses": [
                    {
                      "definitions": [
                        "a hole in one"
                      ],
                      "id": "m_en_gbus0005680.014"
                    }
                  ]
                }
              ]
            }
          ],
          "language": "en-gb",
          "lexicalCategory": {
            "id": "noun",
            "text": "Noun"
          },
          "text": "ace"
        },
        {
          "entries": [
            {
              "homographNumber": "101",
              "senses": [
                {
                  "definitions": [
                    "very good"
                  ],
                  "id": "m_en_gbus0005680.016"
                }
              ]
            }
          ],
          "language": "en-gb",
          "lexicalCategory": {
            "id": "adjective",
            "text": "Adjective"
          },
          "text": "ace"
        },
        {
          "entries": [
            {
              "homographNumber": "102",
              "senses": [
                {
                  "definitions": [
                    "(in tennis and similar games) serve an ace against (an opponent)"
                  ],
                  "id": "m_en_gbus0005680.020",
                  "subsenses": [
                    {
                      "definitions": [
                        "score an ace on (a hole) or with (a shot)"
                      ],
                      "id": "m_en_gbus0005680.026"
                    }
                  ]
                },
                {
                  "definitions": [
                    "achieve high marks in (a test or exam)"
                  ],
                  "id": "m_en_gbus0005680.028",
                  "subsenses": [
                    {
                      "definitions": [
                        "outdo someone in a competitive situation"
                      ],
                      "id": "m_en_gbus0005680.029"
                    }
                  ]
                }
              ]
            }
          ],
          "language": "en-gb",
          "lexicalCategory": {
            "id": "verb",
            "text": "Verb"
          },
          "text": "ace"
        }
      ],
      "type": "headword",
      "word": "ace"
    },
    {
      "id": "ace",
      "language": "en-gb",
      "lexicalEntries": [
        {
          "entries": [
            {
              "homographNumber": "200",
              "senses": [
                {
                  "definitions": [
                    "a person who has no sexual feelings or desires"
                  ],
                  "id": "m_en_gbus1190638.004"
                }
              ]
            }
          ],
          "language": "en-gb",
          "lexicalCategory": {
            "id": "noun",
            "text": "Noun"
          },
          "text": "ace"
        },
        {
          "entries": [
            {
              "homographNumber": "201",
              "senses": [
                {
                  "definitions": [
                    "(of a person) having no sexual feelings or desires; asexual"
                  ],
                  "id": "m_en_gbus1190638.006"
                }
              ]
            }
          ],
          "language": "en-gb",
          "lexicalCategory": {
            "id": "adjective",
            "text": "Adjective"
          },
          "text": "ace"
        }
      ],
      "type": "headword",
      "word": "ace"
    }
  ],
  "word": "ace"
}""";
Future<DefinitionResponse> getDefinition(String word) async {
  // var res = await http.get(
  //   'https://od-api.oxforddictionaries.com/api/v2/entries/en-gb/${word}?fields=definitions&strictMatch=false',
  //   headers: {
  //     "Accept": "application/json",
  //     "app_id": OXFORD_API_KEY,
  //     "app_key": "41a7c270cea477074ce6bf18d8cd22a6"
  //   },
  // );
  return DefinitionResponse.fromJson(def);
}
