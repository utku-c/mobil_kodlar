class ActivitiyModel {
  String? id;
  String? title;
  String? date;
  String? description;
  String? category;
  String? city;
  String? venue;

  ActivitiyModel(
      {this.id,
      this.title,
      this.date,
      this.description,
      this.category,
      this.city,
      this.venue});

  ActivitiyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
    category = json['category'];
    city = json['city'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['description'] = description;
    data['category'] = category;
    data['city'] = city;
    data['venue'] = venue;
    return data;
  }
}
