import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class TabLayout extends LayoutBase {
  final List<BaseModel>? children;

  TabLayout(super.type, super.subType, this.children,
      {super.initAction,
      super.condition,
      super.customDataModel,
      super.consumeCustomDataModel});

  factory TabLayout.fromJson(Map<String, dynamic> json) {
    return TabLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"],
        customDataModel: json["customDataModel"],
        consumeCustomDataModel: json["consumeCustomDataModel"] ?? false);
  }
}
