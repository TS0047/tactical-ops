// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQuote _$UserQuoteFromJson(Map<String, dynamic> json) => _UserQuote(
  id: json['id'] as String,
  text: json['text'] as String,
  author: json['author'] as String?,
  isFavourite: json['isFavourite'] as bool? ?? false,
  isCustom: json['isCustom'] as bool? ?? true,
  createdAt: _tsRequired(json['createdAt']),
);

Map<String, dynamic> _$UserQuoteToJson(_UserQuote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'author': instance.author,
      'isFavourite': instance.isFavourite,
      'isCustom': instance.isCustom,
      'createdAt': _tsTo(instance.createdAt),
    };
