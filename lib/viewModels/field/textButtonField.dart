import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';

class TextButtonField extends FieldBase {
  String? iconUrl, buttonText, buttonTextFieldInData;

  TextButtonField(super.type, super.subType,
      {this.iconUrl,
      this.buttonText,
      this.buttonTextFieldInData,
      super.action,
      super.initAction,
      super.condition});

  @override
  factory TextButtonField.fromJson(Map<String, dynamic> json) {
    return TextButtonField(json["type"], json["subType"],
        iconUrl: json["iconUrl"],
        buttonText: json["buttonText"],
        buttonTextFieldInData: json["buttonTextFieldInData"],
        action: json.containsKey("action")
            ? (json["action"] as List)
                .map((e) => ActionBase.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
