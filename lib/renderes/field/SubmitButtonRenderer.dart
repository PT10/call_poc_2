import 'dart:convert';

import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/field/submitButtonField.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitButtonRenderer extends ElementRenderer {
  final Function(InitActionModel, List<ActionModel>?) onSubmitted;
  const SubmitButtonRenderer(super.type, super.elementModel, this.onSubmitted,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.onAction,
      super.key});

  @override
  _SubmitButtonRendererState createState() => _SubmitButtonRendererState();
}

class _SubmitButtonRendererState
    extends ElementRendererState<SubmitButtonRenderer> {
  @override
  Widget getWidget() {
    DataModel model = Provider.of<DataModel>(context, listen: false);
    SubmitButtonField fieldModel = widget.elementModel as SubmitButtonField;
    return OutlinedButton(
      onPressed: () {
        widget.onSubmitted(fieldModel.submitAction, fieldModel.action);
      },
      child: Text(fieldModel.buttonText ??
          (model.data.containsKey(fieldModel.buttonTextFieldInData)
              ? model.data[fieldModel.buttonTextFieldInData]
              : '')),
    );
  }
}
