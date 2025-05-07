import 'package:equatable/equatable.dart';

class Stat extends Equatable {
  final String name;
  final int value;

  const Stat({
    required this.name,
    required this.value,
  });

  @override
  List<Object> get props => [name, value];

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['name'] as String,
      value: json['base_stat'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'base_stat': value,
    };
  }

  factory Stat.empty() {
    return const Stat(
      name: '',
      value: 0,
    );
  }
} 