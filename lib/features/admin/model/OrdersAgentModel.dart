import 'dart:convert';

OrdersAdminModel ordersAdminModelFromJson(String str) => OrdersAdminModel.fromJson(json.decode(str));

String ordersAdminModelToJson(OrdersAdminModel data) => json.encode(data.toJson());

class OrdersAdminModel {
  List<Order> orders;
  PaginationOrdersUser paginationOrdersUser;

  OrdersAdminModel({
    required this.orders,
    required this.paginationOrdersUser,
  });

  factory OrdersAdminModel.fromJson(Map<String, dynamic> json) => OrdersAdminModel(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    paginationOrdersUser: PaginationOrdersUser.fromJson(json["paginationOrders"]),
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "paginationOrders": paginationOrdersUser.toJson(),
  };

}

class Order {
  int id;
  String phone;
  String address;
  String status;
  DateTime createdAt;
  int totalItems;
  int totalPrice;
  List<Item> items;

  Order({
    required this.id,
    required this.phone,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.totalItems,
    required this.totalPrice,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    phone: json["phone"],
    address: json["address"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    totalItems: json["totalItems"],
    totalPrice: json["totalPrice"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "address": address,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "totalItems": totalItems,
    "totalPrice": totalPrice,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  int quantity;
  int priceAtOrder;
  ProductAgent productAgent;

  Item({
    required this.id,
    required this.quantity,
    required this.priceAtOrder,
    required this.productAgent,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    quantity: json["quantity"],
    priceAtOrder: json["priceAtOrder"],
    productAgent: ProductAgent.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "priceAtOrder": priceAtOrder,
    "product": productAgent.toJson(),
  };
}

class ProductAgent {
  int id;
  String title;
  int price;
  List<String> images;
  Seller seller;

  ProductAgent({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.seller,
  });

  factory ProductAgent.fromJson(Map<String, dynamic> json) => ProductAgent(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    images: List<String>.from(json["images"].map((x) => x)),
    seller: Seller.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "images": List<dynamic>.from(images.map((x) => x)),
    "seller": seller.toJson(),
  };
}

class Seller {
  int id;
  String name;
  String phone;
  String location;
  String role;
  bool isVerified;
  String image;

  Seller({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.role,
    required this.isVerified,
    required this.image,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    role: json["role"],
    isVerified: json["isVerified"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "role": role,
    "isVerified": isVerified,
    "image": image,
  };
}

class PaginationOrdersUser {
  int currentPage;
  int totalPages;
  int totalItems;

  PaginationOrdersUser({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
  });

  factory PaginationOrdersUser.fromJson(Map<String, dynamic> json) => PaginationOrdersUser(
    totalItems: json["totalItems"] ?? 0,
    totalPages: json["totalPages"] ?? 0,
    currentPage: json["currentPage"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalItems": totalItems,
  };
}
