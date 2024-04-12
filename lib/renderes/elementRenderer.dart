import 'dart:convert';

import 'package:call_poc_2/renderes/field/AgoraCallPage.dart';
import 'package:call_poc_2/renderes/field/IconButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/LabelRenderer.dart';
import 'package:call_poc_2/renderes/field/textButtonRenderer.dart';
import 'package:call_poc_2/renderes/layout/ColumnRenderer.dart';
import 'package:call_poc_2/renderes/layout/GridRenderer.dart';
import 'package:call_poc_2/renderes/layout/ListRenderer.dart';
import 'package:call_poc_2/renderes/layout/PopUpRenderer.dart';
import 'package:call_poc_2/renderes/layout/RowRenderer.dart';
import 'package:call_poc_2/renderes/layout/StackRenderer.dart';
import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ElementRenderer extends StatefulWidget {
  // final Widget myCmp;
  final String type;
  final InitActionModel? initAction;
  final BaseModel elementModel;
  final Function(Map<String, dynamic>?) getCmp;
  final Function(String type)? onAction;
  final Function? onPollFinished;
  const ElementRenderer(this.type, this.elementModel,
      {required this.getCmp,
      this.initAction,
      this.onPollFinished,
      this.onAction,
      super.key});

  @override
  State<ElementRenderer> createState() => ElementRendererState();
}

class ElementRendererState<T extends ElementRenderer> extends State<T> {
  bool loadingCompleted = false;
  String? errorMsg;
  @override
  void initState() {
    if (widget.elementModel.initAction != null) {
      _performInitAction();
    } else {
      loadingCompleted = true;
    }
    super.initState();
  }

  _performInitAction({bool pollModel = false}) {
    // Init action can also update the widget.data
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    widget.elementModel.initAction!
        .perform(context, pollMode: pollModel)
        .then((value) {
      setState(() {
        loadingCompleted = true;
        componentData.setData(json.decode(value.body));
      });

      InitAction lastAction = widget.elementModel.initAction!.initActions.last;
      if (lastAction.mode == "poll" && lastAction.breakCondition != null) {
        var resp = json.decode(value.body);
        if (resp[lastAction.breakCondition!["field"]] !=
            lastAction.breakCondition!["value"]) {
          return Future.delayed(Duration(microseconds: 500),
              () => _performInitAction(pollModel: true));
        }

        if (widget.onPollFinished != null) {
          widget.onPollFinished!(lastAction.action);
        }
      }
    }).onError((error, stackTrace) {
      errorMsg = "Error";
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadingCompleted) {
      return getWidget();
    } else if (errorMsg != null) {
      return const Center(
        child: Text("error"),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget getWidget() {
    return Container(
      child: Text("Base class"),
    );
  }
}
