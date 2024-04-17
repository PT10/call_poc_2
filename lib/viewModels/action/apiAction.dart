import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class APIAction extends ActionBase {
  final String api;
  final ActionBase? onSuccess, onFailure;

  final Map<String, dynamic>? params;

  APIAction(super.type,
      {required this.api,
      required this.onSuccess,
      required this.onFailure,
      this.params});

  factory APIAction.fromJson(Map<String, dynamic> json) {
    return APIAction('navigate',
        api: json["api"],
        onSuccess: json.containsKey("onSuccess") &&
                json["onSuccess"].containsKey("action")
            ? ActionBase.fromJson(json["onSuccess"]["action"])
            : null,
        params: json["params"],
        onFailure: json.containsKey("onFailure") &&
                json["onFailure"].containsKey("action")
            ? ActionBase.fromJson(json["onFailure"]["action"])
            : null);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    _updateActionParams(0, componentData.data);

    HttpUtils()
        .post(replaceVariables(api)!, params ?? {})
        .then((value) => onSuccess?.perform(context))
        .onError((error, stackTrace) => onFailure?.perform(context));
  }

  _updateActionParams(int i, Map<String, dynamic> data) {
    params?.keys.forEach((key) {
      if (params?[key] == "__randStr__") {
        params?[key] = Uuid().v4().toString();
        return;
      }
      if (params?[key] is Map<String, dynamic>) {
        if (data.containsKey(params?[key]["oldKey"])) {
          params?[key] = data[params?[key]["oldKey"]];
        }
      } else {
        if (data.containsKey(key)) {
          if (params?[key] is String) {
            params?[key] = data[key].toString();
          } else {
            params?[key] = data[key];
          }
        }
      }
    });
  }
}
