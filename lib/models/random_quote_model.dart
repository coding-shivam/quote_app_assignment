class RandomQuote {
  String sId;
  List<String> tags;
  String content;
  String author;
  String authorSlug;
  int length;
  String dateAdded;
  String dateModified;

  RandomQuote(
      {this.sId,
      this.tags,
      this.content,
      this.author,
      this.authorSlug,
      this.length,
      this.dateAdded,
      this.dateModified});

  RandomQuote.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tags = json['tags'].cast<String>();
    content = json['content'];
    author = json['author'];
    authorSlug = json['authorSlug'];
    length = json['length'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  // Map<String, dynamic> toJson() {
  //      Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['tags'] = this.tags;
  //   data['content'] = this.content;
  //   data['author'] = this.author;
  //   data['authorSlug'] = this.authorSlug;
  //   data['length'] = this.length;
  //   data['dateAdded'] = this.dateAdded;
  //   data['dateModified'] = this.dateModified;
  //   return data;
  // }
}
