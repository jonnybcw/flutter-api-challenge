import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_created.g.dart';

@JsonSerializable()
class UserCreated extends Equatable {
  const UserCreated({
    required this.id,
    required this.name,
    required this.job,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String job;
  final String createdAt;

  factory UserCreated.fromJson(Map<String, dynamic> json) =>
      _$UserCreatedFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreatedToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        job,
        createdAt,
      ];
}
