import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorModel {
  ErrorModel(this.type, this.errors);

  factory ErrorModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ErrorModel('unknown', [
        ErrorsModel('unknown', 'Unknown error, please try again', 'unknown'),
      ]);
    }
    return _$ErrorModelFromJson(json);
  }

  @JsonKey(defaultValue: 'unknown')
  String? type;
  List<ErrorsModel>? errors;

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  @override
  String toString() => 'type: $type, errors: $errors';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorsModel {
  ErrorsModel(this.code, this.detail, this.attr);

  factory ErrorsModel.fromJson(Map<String, dynamic> json) => _$ErrorsModelFromJson(json);

  String? code;
  String? detail;
  String? attr;

  Map<String, dynamic> toJson() => _$ErrorsModelToJson(this);

  @override
  String toString() => 'code: $code, detail: $detail attr: $attr';
}
