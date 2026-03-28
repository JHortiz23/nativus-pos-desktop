class AuthSessionEntity {
	final String accessToken;
	final AuthUserEntity user;
	final AuthRestaurantEntity restaurant;
	final AuthCompanyEntity company;

	const AuthSessionEntity({
		required this.accessToken,
		required this.user,
		required this.restaurant,
		required this.company,
	});
}

class AuthUserEntity {
	final int id;
	final int restaurantId;
	final String name;
	final String email;
	final String role;
	final bool isActive;
	final DateTime createdAt;

	const AuthUserEntity({
		required this.id,
		required this.restaurantId,
		required this.name,
		required this.email,
		required this.role,
		required this.isActive,
		required this.createdAt,
	});
}

class AuthRestaurantEntity {
	final int id;
	final int clientId;
	final String name;
	final String address;
	final String phone;
	final String email;
	final DateTime createdAt;
	final bool isActive;

	const AuthRestaurantEntity({
		required this.id,
		required this.clientId,
		required this.name,
		required this.address,
		required this.phone,
		required this.email,
		required this.createdAt,
		required this.isActive,
	});
}

class AuthCompanyEntity {
	final int id;
	final String name;
	final String email;
	final String phone;
	final DateTime createdAt;

	const AuthCompanyEntity({
		required this.id,
		required this.name,
		required this.email,
		required this.phone,
		required this.createdAt,
	});
}