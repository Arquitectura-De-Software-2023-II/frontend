// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['_id'] as String,
      json['name'] as String,
      json['animal'] as String,
      json['breed'] as String,
      json['color'] as String,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'breed': instance.breed,
      'animal': instance.animal,
    };
