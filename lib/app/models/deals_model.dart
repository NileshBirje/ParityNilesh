class DealsModel {
  int? id;
  int? commentsCount;
  String? createdAt;
  int? createdAtInMillis;
  String? imageMedium;
  Store? store;

  DealsModel(
      {this.id,
      this.commentsCount,
      this.createdAt,
      this.createdAtInMillis,
      this.imageMedium,
      this.store});

  DealsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentsCount = json['comments_count'];
    createdAt = json['created_at'];
    createdAtInMillis = json['created_at_in_millis'];
    imageMedium = json['image_medium'];
    if (json['store'] != null) {
      store = Store.fromJson(json['store']);
    } else {
      store = Store(name: '-');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments_count'] = this.commentsCount;
    data['created_at'] = this.createdAt;
    data['created_at_in_millis'] = this.createdAtInMillis;
    data['image_medium'] = this.imageMedium;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class Store {
  String? name;

  Store({this.name});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '-';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name??'';
    return data;
  }
}
