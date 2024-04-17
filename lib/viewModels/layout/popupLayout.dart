import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class PopupLayout extends LayoutBase {
  final List<BaseModel>? children;
  final List<FieldBase>? actions;

  PopupLayout(super.type, super.subType, this.children,
      {super.title, this.actions, super.initAction, super.condition});

  factory PopupLayout.fromJson(Map<String, dynamic> json) {
    return PopupLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        title: json["title"],
        actions: json.containsKey("actions")
            ? (json["actions"] as List<dynamic>)
                .map((e) => FieldBase.fromJson(e))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
