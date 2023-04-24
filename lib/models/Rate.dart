import 'User.dart';

class Rate {
  Rate({
    this.id,
    this.productId,
    this.rate,
    this.feedback,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  Rate.fromJson(dynamic json) {
    id = json['_id'];
    productId = json['product_id'];
    rate = double.parse(json['rate'].toString());
    feedback = json['feedback'];
    user = json['user'] != null ? json['user'] : "";
    createdAt = json['createdAt'];

    updatedAt = json['updatedAt'];
  }
  String? id;
  String? productId;
  double? rate;
  String? feedback;
  String? user;
  String? createdAt;
  String? updatedAt;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['product_id'] = productId;
    map['rate'] = rate;
    map['feedback'] = feedback;

    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
