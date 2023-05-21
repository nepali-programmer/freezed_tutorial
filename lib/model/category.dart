import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Category({
    required int id,
    @Default('N/A') String categoryName,
    @JsonKey(name: 'description') required String categoryDescription,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
