// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['source'] as String,
      json['author'] as String? ?? 'No author',
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
      json['urlToImage'] as String? ?? 'urlToImage',
      json['publishedAt'] as String? ?? 'No date',
      json['content'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
