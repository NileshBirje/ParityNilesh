// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    SeoSettings? seoSettings;
    List<Deal>? deals;
    Event? event;

    DataModel({
        this.seoSettings,
        this.deals,
        this.event,
    });

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        seoSettings: json["seo_settings"] == null ? null : SeoSettings.fromJson(json["seo_settings"]),
        deals: json["deals"] == null ? [] : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
    );

    Map<String, dynamic> toJson() => {
        "seo_settings": seoSettings?.toJson(),
        "deals": deals == null ? [] : List<dynamic>.from(deals!.map((x) => x.toJson())),
        "event": event?.toJson(),
    };
}

class Deal {
    int? commentsCount;
    String? imageMedium;
    Store? store;

    Deal({
        this.commentsCount,
        this.imageMedium,
        this.store,
    });

    factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        commentsCount: json["comments_count"],
        imageMedium: json["image_medium"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
    );

    Map<String, dynamic> toJson() => {
        "comments_count": commentsCount,
        "image_medium": imageMedium,
        "store": store?.toJson(),
    };
}

class Store {
    String? name;

    Store({
        this.name,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Event {
    int? id;
    String? imageUrl;
    String? pageUrl;

    Event({
        this.id,
        this.imageUrl,
        this.pageUrl,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        imageUrl: json["image_url"],
        pageUrl: json["page_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "page_url": pageUrl,
    };
}

class SeoSettings {
    String? seoTitle;
    String? seoDescription;
    String? webUrl;

    SeoSettings({
        this.seoTitle,
        this.seoDescription,
        this.webUrl,
    });

    factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        webUrl: json["web_url"],
    );

    Map<String, dynamic> toJson() => {
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "web_url": webUrl,
    };
}
