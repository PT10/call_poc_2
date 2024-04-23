import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/labelField.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabelRenderer extends ElementRenderer {
  const LabelRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _LabelRendererState createState() => _LabelRendererState();
}

class _LabelRendererState extends ElementRendererState<LabelRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    LabelField fieldModel = widget.elementModel as LabelField;
    return Wrap(
      children: skipNulls([
        fieldModel.label != null
            ? Text(
                fieldModel.label!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
        fieldModel.valueField != null
            ? Text(
                model.data[fieldModel.valueField]?.toString() ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : null
      ]),
    );
  }
}
