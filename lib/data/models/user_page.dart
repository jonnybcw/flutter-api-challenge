import 'package:equatable/equatable.dart';
import 'package:flutter_api_challenge/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_page.g.dart';

@JsonSerializable()
class UserPage extends Equatable {
  const UserPage({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<User> data;

  factory UserPage.fromJson(Map<String, dynamic> json) =>
      _$UserPageFromJson(json);

  Map<String, dynamic> toJson() => _$UserPageToJson(this);

  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        totalPages,
        data,
      ];
}
