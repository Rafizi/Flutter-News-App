// To parse this JSON data, do
//
//     final newsApp = newsAppFromJson(jsonString);

import 'dart:convert';

NewsApp newsAppFromJson(String str) => NewsApp.fromJson(json.decode(str));

String newsAppToJson(NewsApp data) => json.encode(data.toJson());

class NewsApp {
    String status;
    int totalResults;
    List<Article> articles;

    NewsApp({
        this.status,
        this.totalResults,
        this.articles,
    });

    factory NewsApp.fromJson(Map<String, dynamic> json) => new NewsApp(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: new List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": new List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    Source source;
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    String content;

    Article({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => new Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author == null ? null : author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content == null ? null : content,
    };
}

class Source {
    String id;
    String name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => new Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
    };
}
