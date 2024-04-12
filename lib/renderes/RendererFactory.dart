import 'package:call_poc_2/renderes/field/AgoraCallPage.dart';
import 'package:call_poc_2/renderes/field/DropDownRenderer.dart';
import 'package:call_poc_2/renderes/field/IconButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/LabelRenderer.dart';
import 'package:call_poc_2/renderes/field/SubmitButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/TextRenderer.dart';
import 'package:call_poc_2/renderes/field/textButtonRenderer.dart';
import 'package:call_poc_2/renderes/layout/ColumnRenderer.dart';
import 'package:call_poc_2/renderes/layout/FormRenderer.dart';
import 'package:call_poc_2/renderes/layout/GridRenderer.dart';
import 'package:call_poc_2/renderes/layout/ListRenderer.dart';
import 'package:call_poc_2/renderes/layout/PopUpRenderer.dart';
import 'package:call_poc_2/renderes/layout/RowRenderer.dart';
import 'package:call_poc_2/renderes/layout/StackRenderer.dart';
import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:flutter/material.dart';

class RendererFactory {
  static dynamic getWidget(String type, BaseModel layoutModel,
      {BuildContext? context,
      Function(String)? onAction,
      Function(InitActionModel, List<ActionModel>?)? onFormSubmit,
      Function? onPollFinished}) {
    if (layoutModel.condition != null) {
      var variableName = layoutModel.condition!["var"];
      if (!globalVariables.containsKey(variableName) ||
          globalVariables[variableName] != layoutModel.condition!["val"]) {
        return null;
      }
    }
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
          /* onAction: () {
            Navigator.pop(context!);
          }, */
          onPollFinished: (ActionModel? action) {
            Navigator.pop(context!);
            if (action != null) {
              //action.setData(data, context);
              action.perform(context);
            }
          },
        );
      case 'form':
        return FormRenderer(type, layoutModel, getCmp: (_) {});
      case 'dropDown':
        return DropDownRenderer(type, layoutModel,
            getCmp: (_) {}, onAction: onAction);
      case 'text':
        return TextRenderer(type, layoutModel, getCmp: (_) {});
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
          onAction: (type) => onAction != null ? onAction(type) : null,
        );
      case 'submit':
        return SubmitButtonRenderer(
          'textButton',
          layoutModel,
          onFormSubmit!,
          getCmp: (_) {},
          onAction: (type) => onAction != null ? onAction(type) : null,
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
