import 'dart:convert';

class DefinitionResponse {
  DefinitionResponse({
    this.id,
    this.metadata,
    this.results,
    this.word,
  });

  final String id;
  final Metadata metadata;
  final List<Result> results;
  final String word;

  factory DefinitionResponse.fromJson(String str) =>
      DefinitionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefinitionResponse.fromMap(Map<String, dynamic> json) =>
      DefinitionResponse(
        id: json["id"] == null ? null : json["id"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromMap(json["metadata"]),
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        word: json["word"] == null ? null : json["word"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "metadata": metadata == null ? null : metadata.toMap(),
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toMap())),
        "word": word == null ? null : word,
      };
}

class Metadata {
  Metadata({
    this.operation,
    this.provider,
    this.schema,
  });

  final String operation;
  final String provider;
  final String schema;

  factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
        operation: json["operation"] == null ? null : json["operation"],
        provider: json["provider"] == null ? null : json["provider"],
        schema: json["schema"] == null ? null : json["schema"],
      );

  Map<String, dynamic> toMap() => {
        "operation": operation == null ? null : operation,
        "provider": provider == null ? null : provider,
        "schema": schema == null ? null : schema,
      };
}

class Result {
  Result({
    this.id,
    this.language,
    this.lexicalEntries,
    this.type,
    this.word,
  });

  final String id;
  final String language;
  final List<LexicalEntry> lexicalEntries;
  final String type;
  final String word;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        language: json["language"] == null ? null : json["language"],
        lexicalEntries: json["lexicalEntries"] == null
            ? null
            : List<LexicalEntry>.from(
                json["lexicalEntries"].map((x) => LexicalEntry.fromMap(x))),
        type: json["type"] == null ? null : json["type"],
        word: json["word"] == null ? null : json["word"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "language": language == null ? null : language,
        "lexicalEntries": lexicalEntries == null
            ? null
            : List<dynamic>.from(lexicalEntries.map((x) => x.toMap())),
        "type": type == null ? null : type,
        "word": word == null ? null : word,
      };
}

class LexicalEntry {
  LexicalEntry({
    this.entries,
    this.language,
    this.lexicalCategory,
    this.text,
  });

  final List<Entry> entries;
  final String language;
  final LexicalCategory lexicalCategory;
  final String text;

  factory LexicalEntry.fromJson(String str) =>
      LexicalEntry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LexicalEntry.fromMap(Map<String, dynamic> json) => LexicalEntry(
        entries: json["entries"] == null
            ? null
            : List<Entry>.from(json["entries"].map((x) => Entry.fromMap(x))),
        language: json["language"] == null ? null : json["language"],
        lexicalCategory: json["lexicalCategory"] == null
            ? null
            : LexicalCategory.fromMap(json["lexicalCategory"]),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toMap() => {
        "entries": entries == null
            ? null
            : List<dynamic>.from(entries.map((x) => x.toMap())),
        "language": language == null ? null : language,
        "lexicalCategory":
            lexicalCategory == null ? null : lexicalCategory.toMap(),
        "text": text == null ? null : text,
      };
}

class Entry {
  Entry({
    this.homographNumber,
    this.senses,
  });

  final String homographNumber;
  final List<Sense> senses;

  factory Entry.fromJson(String str) => Entry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Entry.fromMap(Map<String, dynamic> json) => Entry(
        homographNumber:
            json["homographNumber"] == null ? null : json["homographNumber"],
        senses: json["senses"] == null
            ? null
            : List<Sense>.from(json["senses"].map((x) => Sense.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "homographNumber": homographNumber == null ? null : homographNumber,
        "senses": senses == null
            ? null
            : List<dynamic>.from(senses.map((x) => x.toMap())),
      };
}

class Sense {
  Sense({
    this.definitions,
    this.id,
    this.subsenses,
  });

  final List<String> definitions;
  final String id;
  final List<Subsense> subsenses;

  factory Sense.fromJson(String str) => Sense.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sense.fromMap(Map<String, dynamic> json) => Sense(
        definitions: json["definitions"] == null
            ? null
            : List<String>.from(json["definitions"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        subsenses: json["subsenses"] == null
            ? null
            : List<Subsense>.from(
                json["subsenses"].map((x) => Subsense.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "definitions": definitions == null
            ? null
            : List<dynamic>.from(definitions.map((x) => x)),
        "id": id == null ? null : id,
        "subsenses": subsenses == null
            ? null
            : List<dynamic>.from(subsenses.map((x) => x.toMap())),
      };
}

class Subsense {
  Subsense({
    this.definitions,
    this.id,
  });

  final List<String> definitions;
  final String id;

  factory Subsense.fromJson(String str) => Subsense.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subsense.fromMap(Map<String, dynamic> json) => Subsense(
        definitions: json["definitions"] == null
            ? null
            : List<String>.from(json["definitions"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "definitions": definitions == null
            ? null
            : List<dynamic>.from(definitions.map((x) => x)),
        "id": id == null ? null : id,
      };
}

class LexicalCategory {
  LexicalCategory({
    this.id,
    this.text,
  });

  final String id;
  final String text;

  factory LexicalCategory.fromJson(String str) =>
      LexicalCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LexicalCategory.fromMap(Map<String, dynamic> json) => LexicalCategory(
        id: json["id"] == null ? null : json["id"],
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "text": text == null ? null : text,
      };
}
