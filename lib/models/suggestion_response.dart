import 'dart:convert';

class SuggestionResponse {
  SuggestionResponse({
    this.elements,
    this.spellingErrorCount,
  });

  final List<Element> elements;
  final int spellingErrorCount;

  factory SuggestionResponse.fromJson(String str) =>
      SuggestionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuggestionResponse.fromMap(Map<String, dynamic> json) =>
      SuggestionResponse(
        elements: json["elements"] == null
            ? null
            : List<Element>.from(
                json["elements"].map((x) => Element.fromMap(x))),
        spellingErrorCount: json["spellingErrorCount"] == null
            ? null
            : json["spellingErrorCount"],
      );

  Map<String, dynamic> toMap() => {
        "elements": elements == null
            ? null
            : List<dynamic>.from(elements.map((x) => x.toMap())),
        "spellingErrorCount":
            spellingErrorCount == null ? null : spellingErrorCount,
      };
}

class Element {
  Element({
    this.id,
    this.errors,
  });

  final int id;
  final List<Error> errors;

  factory Element.fromJson(String str) => Element.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Element.fromMap(Map<String, dynamic> json) => Element(
        id: json["id"] == null ? null : json["id"],
        errors: json["errors"] == null
            ? null
            : List<Error>.from(json["errors"].map((x) => Error.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "errors": errors == null
            ? null
            : List<dynamic>.from(errors.map((x) => x.toMap())),
      };
}

class Error {
  Error({
    this.word,
    this.position,
    this.suggestions,
  });

  final String word;
  final int position;
  final List<String> suggestions;

  factory Error.fromJson(String str) => Error.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Error.fromMap(Map<String, dynamic> json) => Error(
        word: json["word"] == null ? null : json["word"],
        position: json["position"] == null ? null : json["position"],
        suggestions: json["suggestions"] == null
            ? null
            : List<String>.from(json["suggestions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "word": word == null ? null : word,
        "position": position == null ? null : position,
        "suggestions": suggestions == null
            ? null
            : List<dynamic>.from(suggestions.map((x) => x)),
      };
}
