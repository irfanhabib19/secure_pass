class PasswordModel {
  int? id;
  final String title;
  final String username;
  final String password;
  final String category;
  final String url;
  final String notes;

  PasswordModel({
    this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.category,
    required this.url,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'password': password,
      'category': category,
      'url': url,
      'notes': notes,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map['id'],
      title: map['title'],
      username: map['username'],
      password: map['password'],
      category: map['category'],
      url: map['url'],
      notes: map['notes'],
    );
  }
}
