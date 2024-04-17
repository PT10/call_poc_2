import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MemoryUpdateAction extends ActionBase {
  MemoryUpdateAction(super.type, {this.variable});
  String? variable;

  factory MemoryUpdateAction.fromJson(Map<String, dynamic> json) {
    return MemoryUpdateAction('memoryUpdate', variable: json["var"]);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    globalVariables[variable!] = componentData.data[variable];
    return;
  }
}
