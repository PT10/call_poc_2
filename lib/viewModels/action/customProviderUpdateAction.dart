import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class customProviderUpdate extends ActionBase {
  customProviderUpdate(this.idField, super.type);

  String idField;

  factory customProviderUpdate.fromJson(Map<String, dynamic> json) {
    return customProviderUpdate(json["idField"], 'customProviderUpdate');
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    CustomDataModel? customData =
        Provider.of<CustomDataModel?>(context, listen: false);
    DataModel dataModel = Provider.of<DataModel>(context, listen: false);

    if (customData != null) {
      if (customData.data?.firstWhereOrNull(
              (element) => element[idField] == dataModel.data[idField]) ==
          null) {
        customData.addData(dataModel.data);
      } else {
        customData.removeData(idField, dataModel.data[idField]);
      }
    }

    return;
  }
}
