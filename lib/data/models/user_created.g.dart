// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_created.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreated _$UserCreatedFromJson(Map<String, dynamic> json) => UserCreated(
      id: json['id'] as String,
      name: json['name'] as String,
      job: json['job'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserCreatedToJson(UserCreated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'job': instance.job,
      'createdAt': instance.createdAt,
    };
