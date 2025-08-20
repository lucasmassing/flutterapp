class UserModel {
  String? id;
  String? name;
  String? email;
  String? avatar;
  String? createdAt;

  // Método Construtor
  UserModel({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.createdAt
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
    );
  }

}