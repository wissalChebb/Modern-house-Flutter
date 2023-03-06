import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
    Cart({
        required this.id,
        required this.user,
        required this.products,
        required this.quantity,
        required this.v,
    });

    String id;
    List<String> user;
    List<Product> products;
    int quantity;
    int v;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        user: List<String>.from(json["user"].map((x) => x)),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        quantity: json["quantity"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": List<dynamic>.from(user.map((x) => x)),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "quantity": quantity,
        "__v": v,
    };
}

class Product {
    Product({
        required this.id,
        required this.productname,
        required this.description,
        required this.image,
        required this.price,
        required this.quantity,
        required this.category,
        required this.user,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String productname;
    String description;
    String image;
    int price;
    int quantity;
    String category;
    List<String> user;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        productname: json["productname"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        category: json["category"],
        user: List<String>.from(json["user"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productname": productname,
        "description": description,
        "image": image,
        "price": price,
        "quantity": quantity,
        "category": category,
        "user": List<dynamic>.from(user.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
