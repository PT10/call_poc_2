import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:flutter/src/widgets/framework.dart';

class CloseAction extends ActionBase {
  CloseAction(super.type, {this.variable});
  String? variable;

  factory CloseAction.fromJson(Map<String, dynamic> json) {
    return CloseAction('close', variable: json["var"]);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    actionCallBack!("close");
    return;
  }
}
