import 'dart:convert';

StatsModel statsModelFromJson(String str) => StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
  Users users;
  Orders orders;
  Products products;

  StatsModel({
    required this.users,
    required this.orders,
    required this.products,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
    users: Users.fromJson(json["users"]),
    orders: Orders.fromJson(json["orders"]),
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "users": users.toJson(),
    "orders": orders.toJson(),
    "products": products.toJson(),
  };
}

class Orders {
  int total;
  Map<String, int> status;
  New ordersNew;
  Revenue revenue;

  Orders({
    required this.total,
    required this.status,
    required this.ordersNew,
    required this.revenue,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    total: json["total"],
    status: Map.from(json["status"]).map((k, v) => MapEntry<String, int>(k, v)),
    ordersNew: New.fromJson(json["new"]),
    revenue: Revenue.fromJson(json["revenue"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "status": Map.from(status).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "new": ordersNew.toJson(),
    "revenue": revenue.toJson(),
  };
}

class New {
  int today;
  int thisWeek;
  int thisMonth;

  New({
    required this.today,
    required this.thisWeek,
    required this.thisMonth,
  });

  factory New.fromJson(Map<String, dynamic> json) => New(
    today: json["today"],
    thisWeek: json["thisWeek"],
    thisMonth: json["thisMonth"],
  );

  Map<String, dynamic> toJson() => {
    "today": today,
    "thisWeek": thisWeek,
    "thisMonth": thisMonth,
  };
}

class Revenue {
  int total;

  Revenue({
    required this.total,
  });

  factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
  };
}

class Products {
  int total;
  New productsNew;
  List<ByCategory> byCategory;
  List<TopSeller> topSellers;

  Products({
    required this.total,
    required this.productsNew,
    required this.byCategory,
    required this.topSellers,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    total: json["total"],
    productsNew: New.fromJson(json["new"]),
    byCategory: List<ByCategory>.from(json["byCategory"].map((x) => ByCategory.fromJson(x))),
    topSellers: List<TopSeller>.from(json["topSellers"].map((x) => TopSeller.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "new": productsNew.toJson(),
    "byCategory": List<dynamic>.from(byCategory.map((x) => x.toJson())),
    "topSellers": List<dynamic>.from(topSellers.map((x) => x.toJson())),
  };
}

class ByCategory {
  int categoryId;
  int count;

  ByCategory({
    required this.categoryId,
    required this.count,
  });

  factory ByCategory.fromJson(Map<String, dynamic> json) => ByCategory(
    categoryId: json["categoryId"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "count": count,
  };
}

class TopSeller {
  int userId;
  int count;

  TopSeller({
    required this.userId,
    required this.count,
  });

  factory TopSeller.fromJson(Map<String, dynamic> json) => TopSeller(
    userId: json["userId"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "count": count,
  };
}

class Users {
  int total;
  int verified;
  Roles roles;
  New usersNew;

  Users({
    required this.total,
    required this.verified,
    required this.roles,
    required this.usersNew,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    total: json["total"],
    verified: json["verified"],
    roles: Roles.fromJson(json["roles"]),
    usersNew: New.fromJson(json["new"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "verified": verified,
    "roles": roles.toJson(),
    "new": usersNew.toJson(),
  };
}

class Roles {
  int admin;
  int agent;
  int user;

  Roles({
    required this.admin,
    required this.agent,
    required this.user,
  });

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
    admin: json["admin"],
    agent: json["agent"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "admin": admin,
    "agent": agent,
    "user": user,
  };
}
