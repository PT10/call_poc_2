import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:flutter/src/widgets/framework.dart';

class RefreshAction extends ActionBase {
  RefreshAction(super.type, {this.variable});
  String? variable;

  factory RefreshAction.fromJson(Map<String, dynamic> json) {
    return RefreshAction('refresh', variable: json["var"]);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    actionCallBack!("refresh");
    return;
  }
}
