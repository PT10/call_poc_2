import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:call_poc_2/pages/AgoraCall.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgoraCallPage extends ElementRenderer {
  const AgoraCallPage(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _AgoraCallPageState createState() => _AgoraCallPageState();
}

class _AgoraCallPageState extends ElementRendererState<AgoraCallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget getWidget() {
    DataModel d = Provider.of<DataModel>(context, listen: false);
    return AgoraCall(
        channelName: d.data["channelName"], role: ClientRole.Broadcaster);
  }
}
