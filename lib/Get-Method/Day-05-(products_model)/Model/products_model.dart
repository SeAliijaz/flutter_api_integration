// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

class ProductsModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  ProductsModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final bool? onSale;
  final int? salePercent;
  final int? sold;
  final bool? sliderNew;
  final bool? sliderRecent;
  final bool? sliderSold;
  final String? date;
  final String? title;
  final Categories? categories;
  final Categories? subcat;
  final Shop? shop;
  final String? price;
  final String? saleTitle;
  final String? salePrice;
  final String? description;
  final String? color;
  final String? size;
  final bool? inWishlist;
  final List<Image>? images;

  Datum({
    this.id,
    this.onSale,
    this.salePercent,
    this.sold,
    this.sliderNew,
    this.sliderRecent,
    this.sliderSold,
    this.date,
    this.title,
    this.categories,
    this.subcat,
    this.shop,
    this.price,
    this.saleTitle,
    this.salePrice,
    this.description,
    this.color,
    this.size,
    this.inWishlist,
    this.images,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        onSale: json["on_sale"],
        salePercent: json["sale_percent"],
        sold: json["sold"],
        sliderNew: json["slider_new"],
        sliderRecent: json["slider_recent"],
        sliderSold: json["slider_sold"],
        date: json["date"],
        title: json["title"],
        categories: json["categories"] == null
            ? null
            : Categories.fromJson(json["categories"]),
        subcat:
            json["subcat"] == null ? null : Categories.fromJson(json["subcat"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        price: json["price"],
        saleTitle: json["sale_title"],
        salePrice: json["sale_price"],
        description: json["description"],
        color: json["color"],
        size: json["size"],
        inWishlist: json["in_wishlist"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "on_sale": onSale,
        "sale_percent": salePercent,
        "sold": sold,
        "slider_new": sliderNew,
        "slider_recent": sliderRecent,
        "slider_sold": sliderSold,
        "date": date,
        "title": title,
        "categories": categories?.toJson(),
        "subcat": subcat?.toJson(),
        "shop": shop?.toJson(),
        "price": price,
        "sale_title": saleTitle,
        "sale_price": salePrice,
        "description": description,
        "color": color,
        "size": size,
        "in_wishlist": inWishlist,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Categories {
  final String? id;
  final String? type;
  final int? salePercent;
  final String? date;
  final String? name;
  final String? image;

  Categories({
    this.id,
    this.type,
    this.salePercent,
    this.date,
    this.name,
    this.image,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["_id"],
        type: json["type"],
        salePercent: json["sale_percent"],
        date: json["date"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "sale_percent": salePercent,
        "date": date,
        "name": name,
        "image": image,
      };
}

class Image {
  final String? id;
  final String? url;

  Image({
    this.id,
    this.url,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class Shop {
  final String? id;
  final bool? isActive;
  final String? createdAt;
  final String? name;
  final String? description;
  final String? shopemail;
  final String? shopaddress;
  final String? shopcity;
  final String? userid;
  final String? image;

  Shop({
    this.id,
    this.isActive,
    this.createdAt,
    this.name,
    this.description,
    this.shopemail,
    this.shopaddress,
    this.shopcity,
    this.userid,
    this.image,
  });

  factory Shop.fromRawJson(String str) => Shop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["_id"],
        isActive: json["is_active"],
        createdAt: json["created_At"],
        name: json["name"],
        description: json["description"],
        shopemail: json["shopemail"],
        shopaddress: json["shopaddress"],
        shopcity: json["shopcity"],
        userid: json["userid"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "is_active": isActive,
        "created_At": createdAt,
        "name": name,
        "description": description,
        "shopemail": shopemail,
        "shopaddress": shopaddress,
        "shopcity": shopcity,
        "userid": userid,
        "image": image,
      };
}
