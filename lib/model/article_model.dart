import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  String? author, id, title, imgurl;
  int? likes;
  List<String>? body;
  List<String>? category;
  Timestamp? createdAt;

  ArticleModel.fromMap(Map<String, dynamic> data) {
    author = data['author'];
    title = data['title'];
    id = data['id'];
    imgurl = data['imgurl'];
    likes = data['likes'];
    category = data['category'].map<String>((e) => '$e').toList();
    body = data['body'].map<String>((e) => '$e').toList();
    createdAt = data['createdAt'];
  }

  ArticleModel(this.id, this.title, this.author, this.imgurl, this.likes, this.category, this.body, this.createdAt);

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'id': id,
      'title': title,
      'imgurl': imgurl,
      'likes': likes,
      'body': body,
      'category': category,
      'createdAt': createdAt,
    };
  }
}
