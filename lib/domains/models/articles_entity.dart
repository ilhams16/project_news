class Article {
  final String title;
  final String? description;
  final String url;
  final String? imgUrl;
  final String? publish;
  final String media;

  Article(
    this.media,
    this.title,
    this.description,
    this.url,
    this.imgUrl,
    this.publish,
  );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        json['source']['name'],
        json['title'],
        json['description'],
        json['url'],
        json['urlToImage'],
        json['publishedAt'],
      );
}
