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
  final BaseModel layoutModel;
  final Function(Map<String, dynamic>?) getCmp;
  final Function? onAction;
  final Function? onPollFinished;
  const ElementRenderer(this.type, this.layoutModel,
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
    if (widget.layoutModel.initAction != null) {
      _performInitAction();
    } else {
      loadingCompleted = true;
    }
    super.initState();
  }

  _performInitAction({bool pollModel = false}) {
    // Init action can also update the widget.data
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    widget.layoutModel.initAction!
        .perform(context, pollMode: pollModel)
        .then((value) {
      setState(() {
        loadingCompleted = true;
        componentData.setData(json.decode(value.body));
      });

      InitAction lastAction = widget.layoutModel.initAction!.initActions.last;
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

  Widget _getWidget2() {
    switch (widget.type) {
      case 'column':
        return ColumnRenderer(
          'column',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'row':
        return RowRenderer(
          'row',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'list':
        return ListRenderer(
          'list',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'grid':
        return GridRenderer(
          'grid',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'stack':
        return StackRenderer(
          'stack',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'popup':
        return PopUpRenderer(
          'popup',
          widget.layoutModel,
          getCmp: widget.getCmp,
          onAction: () {
            Navigator.pop(context);
          },
          onPollFinished: (ActionModel? action) {
            // Navigator.pop(context);
            if (action != null) {
              //action.setData(data, context);
              action.perform(context);
            }
          },
        );
      case 'label':
        return LabelRenderer(
          'label',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'iconButton':
        return IconButtonRenderer(
          'iconButton',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      case 'textButton':
        return TextButtonRenderer(
          'textButton',
          widget.layoutModel,
          getCmp: widget.getCmp,
          onAction: widget.onAction,
        );
      case 'agoraCallPage':
        return AgoraCallPage(
          'agoraCallPage',
          widget.layoutModel,
          getCmp: widget.getCmp,
        );
      default:
        return const Center(child: Text("Undefined widget type"));
    }
  }
}
