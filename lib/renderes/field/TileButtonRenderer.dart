import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/iconButtonField.dart';
import 'package:call_poc_2/viewModels/field/tileButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TileButtonRenderer extends ElementRenderer {
  const TileButtonRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _TileButtonRendererState createState() => _TileButtonRendererState();
}

class _TileButtonRendererState
    extends ElementRendererState<TileButtonRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    TileButtonField fieldModel = widget.elementModel as TileButtonField;
    return TextButton.icon(
      onPressed: () {
        if (fieldModel.action != null) {
          fieldModel.action!.forEach((element) =>
              element.perform(context, actionCallBack: widget.onAction));
        }
      },
      icon: const Icon(Icons.close),
      label: Text(fieldModel.buttonText ??
          (model.data.containsKey(fieldModel.buttonTextFieldInData)
              ? model.data[fieldModel.buttonTextFieldInData]
              : '')),
    );
  }
}
