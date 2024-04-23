import 'package:call_poc_2/renderes/field/AgoraCallPage.dart';
import 'package:call_poc_2/renderes/field/DropDownRenderer.dart';
import 'package:call_poc_2/renderes/field/IconButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/LabelRenderer.dart';
import 'package:call_poc_2/renderes/field/SubmitButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/TextRenderer.dart';
import 'package:call_poc_2/renderes/field/TileButtonRenderer.dart';
import 'package:call_poc_2/renderes/field/textButtonRenderer.dart';
import 'package:call_poc_2/renderes/layout/ColumnRenderer.dart';
import 'package:call_poc_2/renderes/layout/FormRenderer.dart';
import 'package:call_poc_2/renderes/layout/GridRenderer.dart';
import 'package:call_poc_2/renderes/layout/ListRenderer.dart';
import 'package:call_poc_2/renderes/layout/PopUpRenderer.dart';
import 'package:call_poc_2/renderes/layout/RowRenderer.dart';
import 'package:call_poc_2/renderes/layout/ScaffoldRenderer.dart';
import 'package:call_poc_2/renderes/layout/StackRenderer.dart';
import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModels/base/dataModel.dart';

class RendererFactory {
  static dynamic getWidget(String type, BaseModel elementModel,
      {BuildContext? context,
      Function(String)? onAction,
      Function(InitActionModel, List<ActionBase>?)? onFormSubmit,
      Function? onPollFinished}) {
    if (elementModel.condition != null &&
        elementModel.condition!["type"] != "customDataModel") {
      var variableName = elementModel.condition!["var"];
      if (!globalVariables.containsKey(variableName) ||
          globalVariables[variableName] != elementModel.condition!["val"]) {
        return null;
      }
    }
    switch (type) {
      case 'scaffold':
        return ScaffoldRenderer('scaffold', elementModel, getCmp: (_) {});
      case 'column':
        return ColumnRenderer(
          'column',
          elementModel,
          getCmp: (_) {},
        );
      case 'row':
        return RowRenderer(
          'row',
          elementModel,
          getCmp: (_) {},
        );
      case 'list':
        return ListRenderer(
          'list',
          elementModel,
          getCmp: (_) {},
        );
      case 'grid':
        return GridRenderer(
          'grid',
          elementModel,
          getCmp: (_) {},
        );
      case 'stack':
        return StackRenderer(
          'stack',
          elementModel,
          getCmp: (_) {},
        );
      case 'popup':
        return PopUpRenderer(
          'popup',
          elementModel,
          getCmp: (_) {},
          /* onAction: () {
            Navigator.pop(context!);
          }, */
          onPollFinished: (ActionBase? action) {
            Navigator.pop(context!);
            if (action != null) {
              //action.setData(data, context);
              action.perform(context);
            }
          },
        );
      case 'form':
        return FormRenderer(type, elementModel, getCmp: (_) {});
      case 'dropDown':
        return DropDownRenderer(type, elementModel,
            getCmp: (_) {}, onAction: onAction);
      case 'text':
        return TextRenderer(type, elementModel, getCmp: (_) {});
      case 'label':
        return LabelRenderer(
          'label',
          elementModel,
          getCmp: (_) {},
        );
      case 'iconButton':
        return IconButtonRenderer(
          'iconButton',
          elementModel,
          getCmp: (_) {},
        );
      case 'tileButton':
        return TileButtonRenderer(
          'tileButton',
          elementModel,
          getCmp: (_) {},
        );
      case 'textButton':
        return TextButtonRenderer(
          'textButton',
          elementModel,
          getCmp: (_) {},
          onAction: (type) => onAction != null ? onAction(type) : null,
        );
      case 'submit':
        return SubmitButtonRenderer(
          'textButton',
          elementModel,
          onFormSubmit!,
          getCmp: (_) {},
          onAction: (type) => onAction != null ? onAction(type) : null,
        );
      case 'agoraCallPage':
        return AgoraCallPage(
          'agoraCallPage',
          elementModel,
          getCmp: (_) {},
        );

      default:
        return const Center(child: Text("Undefined widget type"));
    }
  }
}
