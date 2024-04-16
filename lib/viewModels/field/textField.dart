import 'package:call_poc_2/viewModels/field/fieldBase.dart';

class TextFieldCustom extends FieldBase {
  String id;
  String? label, hintText, initialText;
  bool obscure;

  TextFieldCustom(super.type, super.subType, this.id,
      {this.label,
      this.hintText,
      this.initialText,
      this.obscure = false,
      super.condition});

  @override
  factory TextFieldCustom.fromJson(Map<String, dynamic> json) {
    return TextFieldCustom(json["type"], json["subType"], json["id"],
        label: json["label"],
        obscure: json["obscure"] ?? false,
        hintText: json["hintText"],
        initialText: json["initialText"],
        condition: json["condition"]);
  }
}
