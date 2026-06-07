import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_quote.freezed.dart';
part 'user_quote.g.dart';

@freezed
abstract class UserQuote with _$UserQuote {
  const factory UserQuote({
    required String id,
    required String text,
    String? author,
    @Default(false) bool isFavourite,
    @Default(true) bool isCustom,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime createdAt,
  }) = _UserQuote;

  factory UserQuote.fromJson(Map<String, dynamic> json) =>
      _$UserQuoteFromJson(json);
}

DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
