class ExcelModel {
  final String name;
  final String email;

  ExcelModel({required this.name, required this.email});

  factory ExcelModel.fromJson(Map<String, dynamic> json) {
    return ExcelModel(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
