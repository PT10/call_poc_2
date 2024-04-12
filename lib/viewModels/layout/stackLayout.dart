import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class StackLayout extends LayoutBase {
  final List<BaseModel>? children;

  StackLayout(super.type, super.subType, this.children,
      {super.title, super.initAction, super.condition});

  factory StackLayout.fromJson(Map<String, dynamic> json) {
    return StackLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        title: json["title"],
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
