import 'dart:io';

class UserProfile {
  final String id;
  final String name;
  final String position;
  final String workplace;
  final int expirienceYears;
  final int expirienceMonths;
  final String? avatarPath;
  final String? avatarUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.position,
    required this.workplace,
    required this.expirienceYears,
    required this.expirienceMonths,
    this.avatarPath,
    this.avatarUrl,
  });

  // Преобразование из Json дл БД
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      workplace: json['workplace'] ?? '',
      expirienceMonths: json['expirienceMonths'] ?? 0,
      expirienceYears: json['expirienceYears'] ?? 0,
      avatarPath: json['avatarPath'],
      avatarUrl: json['avatarUrl'],
    );
  }

  //Преобразование в Json для БД
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'workplace': workplace,
      'expirienceMonths': expirienceMonths,
      'expirienceYears': expirienceYears,
      'avatarPath': avatarPath,
      'avatarUrl': avatarUrl,
    };
  }

  //Создание копии с изменениями
  UserProfile copyWidth({
    String? id,
    String? name,
    String? position,
    String? workplace,
    int? expirienceMonths,
    int? expirienceYears,
    String? avatarPath,
    String? avatarUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      workplace: workplace ?? this.workplace,
      expirienceMonths: expirienceMonths ?? this.expirienceMonths,
      expirienceYears: expirienceYears ?? this.expirienceYears,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  // Форматированная строка с опытом
  String get formattedExpirience {
    if (expirienceYears == 0) {
      return '$expirienceMonths месяцев';
    }
    return '$expirienceYears Год $expirienceMonths Месяцев';
  }
}