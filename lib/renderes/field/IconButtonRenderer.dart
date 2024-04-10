import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/iconButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonRenderer extends ElementRenderer {
  const IconButtonRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _IconButtonRendererState createState() => _IconButtonRendererState();
}

class _IconButtonRendererState
    extends ElementRendererState<IconButtonRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    IconButtonField fieldModel = widget.layoutModel as IconButtonField;
    return TextButton.icon(
      onPressed: () {
        if (widget.onAction != null) {
          widget
              .onAction!(); // Action performed on the parent component.. e.g. close popup window
        }
        if (fieldModel.action != null) {
          //action!.setData(resp, context);
          // action!.perform(context);
          // DataModel d = Provider.of<DataModel>(context, listen: false);
          // d.setData(resp ?? {});
          fieldModel.action!.perform(context);
        }
      },
      icon: const Icon(Icons.plus_one),
      label: Text(fieldModel.buttonText ??
          (model.data.containsKey(fieldModel.buttonTextFieldInData)
              ? model.data[fieldModel.buttonTextFieldInData]
              : '')),
    );
  }
}
