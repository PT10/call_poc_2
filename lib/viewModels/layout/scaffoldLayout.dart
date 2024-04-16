import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:call_poc_2/viewModels/layout/appBarLayout.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class ScaffoldLayout extends LayoutBase {
  final List<BaseModel>? children;
  final AppBarLayout? appBar;
  final List<TextButtonField>? bottomBar;

  ScaffoldLayout(super.type, super.subType, this.children,
      {super.title,
      this.appBar,
      this.bottomBar,
      super.initAction,
      super.condition});

  factory ScaffoldLayout.fromJson(Map<String, dynamic> json) {
    return ScaffoldLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        title: json["title"],
        appBar: json.containsKey("appBar")
            ? AppBarLayout.fromJson(json["appBar"])
            : null,
        bottomBar: json.containsKey("bottomBar")
            ? (json["bottomBar"] as List<Map<String, dynamic>>)
                .map((e) => TextButtonField.fromJson(e))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
