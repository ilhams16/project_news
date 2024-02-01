import 'package:hive/hive.dart';

part 'fav_news.g.dart';

@HiveType(typeId: 0)
class FavoriteNews extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String url;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? imgUrl;

  @HiveField(4)
  String? publish;

  @HiveField(5)
  String media;

  @HiveField(6)
  bool fav;

  FavoriteNews(this.title, this.url, this.description, this.imgUrl, this.media,
      this.publish, this.fav);
}
