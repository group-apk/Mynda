class ArticleModel {
  String? author, id, title;
  //late List<String> body;
  List<String>? category;

  ArticleModel.fromMap(Map<String, dynamic> data) {
    author = data['author'];
    title = data['title'];
    id = data['id'];
    category = data['category'].map<String>((e) => '$e').toList();
    print(data['category']);
  }

  ArticleModel(this.id, this.title, this.author, this.category);

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'id': id,
      'title': title,
      //'body':body,
      'category': category,
    };
  }
}
