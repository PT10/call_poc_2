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
import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:flutter/material.dart';

class RendererFactory {
  static dynamic getWidget(String type, BaseModel layoutModel,
      {BuildContext? context, Function? onAction, Function? onPollFinished}) {
    switch (type) {
      case 'column':
        return ColumnRenderer(
          'column',
          layoutModel,
          getCmp: (_) {},
        );
      case 'row':
        return RowRenderer(
          'row',
          layoutModel,
          getCmp: (_) {},
        );
      case 'list':
        return ListRenderer(
          'list',
          layoutModel,
          getCmp: (_) {},
        );
      case 'grid':
        return GridRenderer(
          'grid',
          layoutModel,
          getCmp: (_) {},
        );
      case 'stack':
        return StackRenderer(
          'stack',
          layoutModel,
          getCmp: (_) {},
        );
      case 'popup':
        return PopUpRenderer(
          'popup',
          layoutModel,
          getCmp: (_) {},
          onAction: () {
            Navigator.pop(context!);
          },
          onPollFinished: (ActionModel? action) {
            Navigator.pop(context!);
            if (action != null) {
              //action.setData(data, context);
              action.perform(context);
            }
          },
        );
      case 'label':
        return LabelRenderer(
          'label',
          layoutModel,
          getCmp: (_) {},
        );
      case 'iconButton':
        return IconButtonRenderer(
          'iconButton',
          layoutModel,
          getCmp: (_) {},
        );
      case 'textButton':
        return TextButtonRenderer(
          'textButton',
          layoutModel,
          getCmp: (_) {},
          onAction: onAction,
        );
      case 'agoraCallPage':
        return AgoraCallPage(
          'agoraCallPage',
          layoutModel,
          getCmp: (_) {},
        );
      default:
        return const Center(child: Text("Undefined widget type"));
    }
  }
}
