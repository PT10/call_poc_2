import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class FormLayout extends LayoutBase {
  final List<FieldBase>? children;
  final List<FieldBase>? actions;

  FormLayout(super.type, super.subType, this.children, this.actions,
      {super.title, super.initAction, super.condition});

  factory FormLayout.fromJson(Map<String, dynamic> json) {
    return FormLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => FieldBase.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        (json["actions"] as List<dynamic>)
            .map((p) => FieldBase.fromJson(p as Map<String, dynamic>))
            .toList(),
        title: json["title"],
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
