import 'package:nativus_pos_desktop/core/utils/helpers/json_parsing_helper.dart';
import 'package:nativus_pos_desktop/features/auth/domain/entities/auth_entity.dart';

class AuthLoginRequestModel {
  final String email;
  final String pin;
  final String expiresIn;

  const AuthLoginRequestModel({
    required this.email,
    required this.pin,
    this.expiresIn = '12h',
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'pin': pin, 'expiresIn': expiresIn};
  }
}

class AuthLoginResponseModel {
  final String accessToken;
  final AuthUserModel user;
  final AuthRestaurantModel restaurant;
  final AuthCompanyModel company;

  const AuthLoginResponseModel({
    required this.accessToken,
    required this.user,
    required this.restaurant,
    required this.company,
  });

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponseModel(
      accessToken: JsonParsingHelper.asString(json['accessToken']),
      user: AuthUserModel.fromJson(JsonParsingHelper.asMap(json['user'])),
      restaurant: AuthRestaurantModel.fromJson(
        JsonParsingHelper.asMap(json['restaurant']),
      ),
      company: AuthCompanyModel.fromJson(
        JsonParsingHelper.asMap(json['company']),
      ),
    );
  }

  AuthSessionEntity toEntity() {
    return AuthSessionEntity(
      accessToken: accessToken,
      user: user.toEntity(),
      restaurant: restaurant.toEntity(),
      company: company.toEntity(),
    );
  }
}

class AuthUserModel {
  final int id;
  final int restaurantId;
  final String name;
  final String email;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const AuthUserModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: JsonParsingHelper.asInt(json['id']),
      restaurantId: JsonParsingHelper.asInt(json['restaurantId']),
      name: JsonParsingHelper.asString(json['name']),
      email: JsonParsingHelper.asString(json['email']),
      role: JsonParsingHelper.asString(json['role']),
      isActive: JsonParsingHelper.asBool(json['isActive']),
      createdAt: DateTime.parse(JsonParsingHelper.asString(json['createdAt'])),
    );
  }

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      id: id,
      restaurantId: restaurantId,
      name: name,
      email: email,
      role: role,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

class AuthRestaurantModel {
  final int id;
  final int clientId;
  final String name;
  final String address;
  final String phone;
  final String email;
  final DateTime createdAt;
  final bool isActive;

  const AuthRestaurantModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.isActive,
  });

  factory AuthRestaurantModel.fromJson(Map<String, dynamic> json) {
    return AuthRestaurantModel(
      id: JsonParsingHelper.asInt(json['id']),
      clientId: JsonParsingHelper.asInt(json['clientId']),
      name: JsonParsingHelper.asString(json['name']),
      address: JsonParsingHelper.asString(json['address']),
      phone: JsonParsingHelper.asString(json['phone']),
      email: JsonParsingHelper.asString(json['email']),
      createdAt: DateTime.parse(JsonParsingHelper.asString(json['createdAt'])),
      isActive: JsonParsingHelper.asBool(json['isActive']),
    );
  }

  AuthRestaurantEntity toEntity() {
    return AuthRestaurantEntity(
      id: id,
      clientId: clientId,
      name: name,
      address: address,
      phone: phone,
      email: email,
      createdAt: createdAt,
      isActive: isActive,
    );
  }
}

class AuthCompanyModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime createdAt;

  const AuthCompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
  });

  factory AuthCompanyModel.fromJson(Map<String, dynamic> json) {
    return AuthCompanyModel(
      id: JsonParsingHelper.asInt(json['id']),
      name: JsonParsingHelper.asString(json['name']),
      email: JsonParsingHelper.asString(json['email']),
      phone: JsonParsingHelper.asString(json['phone']),
      createdAt: DateTime.parse(JsonParsingHelper.asString(json['createdAt'])),
    );
  }

  AuthCompanyEntity toEntity() {
    return AuthCompanyEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      createdAt: createdAt,
    );
  }
}
