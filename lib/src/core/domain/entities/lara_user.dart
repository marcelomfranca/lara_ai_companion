class LaraUser {
  const LaraUser({
    required this.id,
    required this.email,
    this.name,
    this.createdAt,
    this.photoUrl,
    this.isGuest = false,
  });

  final String id;
  final String email;
  final String? name;
  final DateTime? createdAt;
  final String? photoUrl;
  final bool isGuest;

  static const empty = LaraUser(id: '', email: '');

  bool get isEmpty => id.isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LaraUser &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.isGuest == isGuest;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      isGuest.hashCode;
}
