import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextRenderer extends ElementRenderer {
  const TextRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _TextRendererState createState() => _TextRendererState();
}

class _TextRendererState extends ElementRendererState<TextRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    TextButtonField fieldModel = widget.layoutModel as TextButtonField;
    return TextButton(
      onPressed: () {
        if (widget.onAction != null) {
          widget
              .onAction!(); // Action performed on the parent component.. e.g. close popup window
        }
        if (fieldModel.action != null) {
          //action!.setData(resp);
          //action!.perform(context);
          //DataModel d = Provider.of<DataModel>(context, listen: false);
          //d.setData(resp ?? {});
          fieldModel.action!.perform(context);
        }
      },
      child: Text(fieldModel.buttonText ??
          (model.data.containsKey(fieldModel.buttonTextFieldInData)
              ? model.data[fieldModel.buttonTextFieldInData]
              : '')),
    );
  }
}
