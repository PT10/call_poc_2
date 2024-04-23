import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/iconButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonRenderer extends ElementRenderer {
  const IconButtonRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _IconButtonRendererState createState() => _IconButtonRendererState();
}

class _IconButtonRendererState
    extends ElementRendererState<IconButtonRenderer> {
  @override
  Widget getWidget() {
    if ((widget.elementModel.consumeCustomDataModel ?? false) &&
        widget.elementModel.condition != null &&
        widget.elementModel.condition!["type"] == "customDataModel") {}
    DataModel model = Provider.of<DataModel>(context, listen: false);
    IconButtonField fieldModel = widget.elementModel as IconButtonField;
    String labelText = fieldModel.buttonText ??
        (model.data.containsKey(fieldModel.buttonTextFieldInData)
            ? model.data[fieldModel.buttonTextFieldInData]
            : '');
    /* if (labelText == "Add to Group" &&
          customModel.contains("_id", "65cc70e7031272e86629f521")) {
        labelText = "Remove from Group";
      } */
    return TextButton.icon(
      onPressed: () {
        /* if (widget.onAction != null) {
          widget
              .onAction!(); // Action performed on the parent component.. e.g. close popup window
        } */
        if (fieldModel.action != null) {
          //action!.setData(resp, context);
          // action!.perform(context);
          // DataModel d = Provider.of<DataModel>(context, listen: false);
          // d.setData(resp ?? {});
          fieldModel.action!.forEach((element) =>
              element.perform(context, actionCallBack: widget.onAction));
        }
      },
      icon: const Icon(Icons.plus_one),
      label: Text(labelText),
    );
  }
}
