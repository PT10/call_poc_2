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
  static Widget? getWidget(String type, BaseModel elementModel,
      {required BuildContext context,
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

    if (elementModel.consumeCustomDataModel ?? false) {
      return Consumer<CustomDataModel?>(
          builder: (context, currentCustomModel, child) {
        if (elementModel.condition != null &&
            elementModel.condition!["type"] == "customDataModel") {
          DataModel componentData =
              Provider.of<DataModel>(context, listen: false);

          if (currentCustomModel != null) {
            if (elementModel.condition!["op"] == "contains") {
              if (!currentCustomModel.contains(
                  elementModel.condition!["idField"],
                  componentData.data[elementModel.condition!["idField"]])) {
                return Container();
              }
            } else if (elementModel.condition!["op"] == "!contains") {
              if (currentCustomModel.contains(
                  elementModel.condition!["idField"],
                  componentData.data[elementModel.condition!["idField"]])) {
                return Container();
              }
            }
          }
        }
        return _getWidget(currentCustomModel, type, elementModel,
            context: context,
            onAction: onAction,
            onFormSubmit: onFormSubmit,
            onPollFinished: onPollFinished);
      });
    }
    // Check if the parent has the customDataModel
    CustomDataModel? parentDataModel =
        Provider.of<CustomDataModel?>(context, listen: false);
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    if (parentDataModel != null &&
        elementModel.condition != null &&
        elementModel.condition!["type"] == "customDataModel") {
      if (elementModel.condition!["op"] == "contains") {
        if (!parentDataModel.contains(elementModel.condition!["idField"],
            componentData.data[elementModel.condition!["idField"]])) {
          return null;
        }
      } else if (elementModel.condition!["op"] == "!contains") {
        if (parentDataModel.contains(elementModel.condition!["idField"],
            componentData.data[elementModel.condition!["idField"]])) {
          return null;
        }
      }
    }

    return _getWidget(null, type, elementModel,
        context: context,
        onAction: onAction,
        onFormSubmit: onFormSubmit,
        onPollFinished: onPollFinished);
  }

  static Widget _getWidget(
      CustomDataModel? customDataModel, String type, BaseModel elementModel,
      {BuildContext? context,
      Function(String)? onAction,
      Function(InitActionModel, List<ActionBase>?)? onFormSubmit,
      Function? onPollFinished}) {
    switch (type) {
      case 'scaffold':
        return ScaffoldRenderer(
          'scaffold',
          elementModel,
          customDataModel: customDataModel,
        );
      case 'column':
        return ColumnRenderer('column', elementModel,
            customDataModel: customDataModel);
      case 'row':
        return RowRenderer('row', elementModel,
            customDataModel: customDataModel);
      case 'list':
        return ListRenderer('list', elementModel,
            customDataModel: customDataModel);
      case 'grid':
        return GridRenderer('grid', elementModel,
            customDataModel: customDataModel);
      case 'stack':
        return StackRenderer('stack', elementModel,
            customDataModel: customDataModel);
      case 'popup':
        return PopUpRenderer(
          'popup',
          elementModel,
          customDataModel: customDataModel,
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
        return FormRenderer(type, elementModel,
            customDataModel: customDataModel);
      case 'dropDown':
        return DropDownRenderer(type, elementModel,
            onAction: onAction, customDataModel: customDataModel);
      case 'text':
        return TextRenderer(type, elementModel,
            customDataModel: customDataModel);
      case 'label':
        return LabelRenderer('label', elementModel,
            customDataModel: customDataModel);
      case 'iconButton':
        return IconButtonRenderer('iconButton', elementModel,
            customDataModel: customDataModel);
      case 'tileButton':
        return TileButtonRenderer('tileButton', elementModel,
            customDataModel: customDataModel);
      case 'textButton':
        return TextButtonRenderer(
          'textButton',
          elementModel,
          onAction: (type) => onAction != null ? onAction(type) : null,
          customDataModel: customDataModel,
        );
      case 'submit':
        return SubmitButtonRenderer('textButton', elementModel, onFormSubmit!,
            onAction: (type) => onAction != null ? onAction(type) : null,
            customDataModel: customDataModel);
      case 'agoraCallPage':
        return AgoraCallPage('agoraCallPage', elementModel,
            customDataModel: customDataModel);

      default:
        return const Center(child: Text("Undefined widget type"));
    }
  }
}
