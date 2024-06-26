import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextButtonRenderer extends ElementRenderer {
  const TextButtonRenderer(super.type, super.layoutModel,
      {super.initAction,
      super.onPollFinished,
      super.onAction,
      super.customDataModel,
      super.key});

  @override
  _TextButtonRendererState createState() => _TextButtonRendererState();
}

class _TextButtonRendererState
    extends ElementRendererState<TextButtonRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    TextButtonField fieldModel = widget.elementModel as TextButtonField;
    return TextButton(
      onPressed: () {
        /* if (widget.onAction != null) {
          widget
              .onAction!(); // Action performed on the parent component.. e.g. close popup window
        } */
        if (fieldModel.action != null) {
          fieldModel.action!.forEach((element) =>
              element.perform(context, actionCallBack: widget.onAction));
        }
      },
      child: Text(fieldModel.buttonText ??
          (model.data.containsKey(fieldModel.buttonTextFieldInData)
              ? model.data[fieldModel.buttonTextFieldInData]
              : '')),
    );
  }
}
