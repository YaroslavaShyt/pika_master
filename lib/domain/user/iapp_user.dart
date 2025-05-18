abstract interface class IAppUser {
  IAppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
  });

  final String id;
  final String name;
  final String? email;
  final String? profilePhoto;
}
