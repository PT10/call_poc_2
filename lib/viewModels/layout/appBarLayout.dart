import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';

class AppBarLayout extends LayoutBase {
  String? title;
  List<FieldBase>? actions;
  List<TextButtonField>? menu;
  AppBarLayout(super.type, super.subType,
      {this.title, this.actions, this.menu});

  factory AppBarLayout.fromJson(Map<String, dynamic> json) {
    return AppBarLayout(json["type"], json["subType"],
        title: json["title"],
        actions: (json["actions"] as List)
            .map((e) => FieldBase.fromJson(e))
            .toList(),
        menu: (json["menu"] as List)
            .map((e) => TextButtonField.fromJson(e))
            .toList());
  }
}
