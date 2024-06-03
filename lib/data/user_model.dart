class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String bloodType;
  final String birthDate;
  final String weight;
  final String medicalHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodType,
    required this.birthDate,
    required this.weight,
    required this.medicalHistory,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['nome'],
      email: json['email'],
      phone: json['telefone'],
      address: json['endereco'],
      bloodType: json['tipo_sanguineo'],
      birthDate: json['data_nascimento'],
      weight: json['peso'].toString(),
      medicalHistory: json['historico_medico'],
    );
  }
}
