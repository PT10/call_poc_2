import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:call_poc_2/pages/AgoraCall.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AgoraCallPage extends FieldBase {
  AgoraCallPage(super.type, super.subType);

  @override
  Widget render(BuildContext context, {Function? onAction}) {
    return ElementRenderer(
      getCmp: (resp) => _getCmp(context, resp, onAction: onAction),
      initAction: initAction,
      data: data,
    );
  }

  Widget _getCmp(BuildContext context, Map<String, dynamic>? resp,
      {Function? onAction}) {
    return AgoraCall(
        channelName: data["channelName"], role: ClientRole.Broadcaster);
  }

  @override
  factory AgoraCallPage.fromJson(Map<String, dynamic> json) {
    return AgoraCallPage(json["type"], json["subType"]);
  }
}
