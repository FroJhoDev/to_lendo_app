import 'package:packages/packages.dart';

/// {@template user_model}
/// Model representing a user in the application.
/// {@endtemplate}
class UserModel {
  /// {@macro user_model}
  const UserModel({required this.id, required this.email, this.name, this.avatarUrl, this.createdAt});

  /// Creates a [UserModel] from a Supabase [User].
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: user.createdAt.isNotEmpty ? DateTime.parse(user.createdAt) : null,
    );
  }

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
    );
  }

  /// User ID (UUID from Supabase)
  final String id;

  /// User email
  final String email;

  /// User full name (optional)
  final String? name;

  /// URL of user's avatar/profile picture (optional)
  final String? avatarUrl;

  /// Account creation date (optional)
  final DateTime? createdAt;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (createdAt != null) 'created_at': createdAt?.toIso8601String() ?? '',
    };
  }

  /// Creates a copy of this model with updated fields.
  UserModel copyWith({String? id, String? email, String? name, String? avatarUrl, DateTime? createdAt}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
