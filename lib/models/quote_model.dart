class Quote {
  String text;
  String author;

  Quote({
  required this.text,
  required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'] as String,
      author: json['author'] as String,

    );

  }
  Map<String, dynamic> toJson() => {
    "text": text,
    "author": author,
  };
}