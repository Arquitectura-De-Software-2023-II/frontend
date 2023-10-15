// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['name'] as String,
      json['animal'] as String,
      json['breed'] as String,
      json['color'] as String,
      json['age'] as int,
      (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'color': instance.color,
      'breed': instance.breed,
      'animal': instance.animal,
      'weight': instance.weight,
    };
